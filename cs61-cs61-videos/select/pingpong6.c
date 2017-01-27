// This is a the first in a sequence of simple program demonstrating
// the need for synchronization between two processes.  The later version
// solve the problem using pipes.
//
// The parent forks two children, one of whom is supposed to
// print ping to stdout; the other of whom is supposed to print pong. But
// the children must synchronize so that the pings and pongs alternate.
// We construct two pipes -- the ping child must read a token from the ping
// pipe before printing its character; the pong child must read a token from
// the pong pipe before printing its character.

#include <assert.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>

// Now, we only want the set of processes to run for 5 seconds, BUT we want
// to exit immediately if either of the children die -- how can we do both?

// timestamp()
//    Return the current time as a double.

static inline double timestamp(void) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + tv.tv_usec / 1000000.0;
}
void child_handler(int signal) {
    (void) signal;
}

void alrm_die_handler(int signal) {
    exit(1);
}

int
main(void)
{
    double start_time;
    char token;
    int pingpipe[2], pongpipe[2], timetosleep;
    int p, reaped_ping, reaped_pong, ret;
    pid_t pingpid, pongpid, status;
    struct itimerval itimer;

    reaped_ping = reaped_pong = 0;

    // Create the two pipes
    if (pipe(pingpipe) || pipe(pongpipe)) {
        fprintf(stderr, "pingpong: unable to create pipes %s\n",
                strerror(errno));
    }

    // Set up ping process
     pingpid = fork();
     switch (pingpid) {
         case 0:
             // Child ping process -- only writes "ping" after a successful
             // read on the ping pipe
             close(pingpipe[1]);
             close(pongpipe[0]);
             // Let's set a timer to go off in 1 second and then exit!
             signal(SIGALRM, alrm_die_handler);
             timerclear(&itimer.it_interval);
             itimer.it_value.tv_sec = 1;
             itimer.it_value.tv_usec = 0;
             ret = setitimer(ITIMER_REAL, &itimer, NULL);
             while (1) {
                 if (read(pingpipe[0], &token, 1) != 1)
                     break;
                 printf("ping\n");
                 fflush(stdout);
                 if (write(pongpipe[1], &token, 1) != 1)
                     break;
             }
             break;
         case -1:
             fprintf(stderr, "pingpong: fork failed %s\n", strerror(errno));
             return (-1);
             break;
         default:
             // Fall through to create next process
             break;
     }

     // Set up pong process
     pongpid = fork();
     switch (pongpid) {
         case 0:
             // Child pong process -- only pong after reading a character
             // from the pong pipe
             close(pingpipe[0]);
             close(pongpipe[1]);
             while (1) {
                 if (read(pongpipe[0], &token, 1) != 1)
                     break;
                 printf("pong\n");
                 fflush(stdout);
                 if (write(pingpipe[1], &token, 1) != 1)
                     break;
             }
             exit(1);
             break;
         case -1:
             fprintf(stderr,
                 "pingpong: second fork failed %s\n", strerror(errno));
             return (-1);
             break;
         default:
             // Fall through reap children
             break;
    }
    // Get things started by writing into the pingpipe and then
    // close the pipes, so there aren't any extraneous opens
    write(pingpipe[1], &token, 1);
    close(pingpipe[0]);
    close(pingpipe[1]);
    close(pongpipe[0]);
    close(pongpipe[1]);

    // Now, we want to see if we can either wait until the children
    // exit or 5 seconds; whichever is longer.  Recall that we tried
    // to do something similar with our wait applications and we
    // encountered race conditions -- we 'll show those here and
    // then design a good solution.
    //
    // This is race #2: We register a signal handler so that we'll
    // be wakened when either exits. If we end up sleeping the full
    // time, then we time out and kill any still-running children.

    // Step 1: register a signal handler to catch child exits
    start_time = timestamp();
    signal(SIGCHLD, child_handler);

    // RACE CONDITION -- if the children exit before we sleep, then
    // we'll sleep the whole time!
    
    // Step 2: Sleep for a designated period of time
    timetosleep = 5;
    while ((p = sleep(timetosleep)) != 0) {
        timetosleep -= p;
        // Check if one or both children have exited.
        if (waitpid(pingpid, &status, 0) == pingpid)
            reaped_ping = 1;

        if (waitpid(pongpid, &status, 0) == pongpid)
            reaped_pong = 1;
        if (reaped_ping && reaped_pong)
            break;
    }

    // If we got here, either we slept the whole time or both
    // children have exited.

    printf("Parent getting ready to exitafter %g sec\n",
        timestamp() - start_time);
    if (p != 0) {
        printf("Both children exited with %d seconds to spare\n", p);
    } else {
        printf("Parent timed out\n");
        if (!reaped_ping)
            kill(pingpid, SIGINT);
        if (!reaped_pong)
            kill(pongpid, SIGINT);
    }
}
