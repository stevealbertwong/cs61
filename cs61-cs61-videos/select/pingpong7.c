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
#include <sys/select.h>
#include <sys/types.h>
#include <sys/wait.h>

// Now, we only want the set of processes to run for 5 seconds, BUT we want
// to exit immediately if either of the children die -- how can we do both?
// Demonstrate using of a signal pipe and select to solve the synchronization
// problem.

// timestamp()
//    Return the current time as a double.

static inline double timestamp(void) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + tv.tv_usec / 1000000.0;
}

// Global signal pipe used to communicate between the mainline program and
// the signal handler.
int signalpipe[2];

// SIGCHLD handler that writes into our pipe
void child_handler(int signal) {
    char c;
    (void)signal;
    assert(write(signalpipe[1], &c, 1) == 1);
}

void alrm_die_handler(int signal) {
    exit(1);
}

int
main(void)
{
    double start_time;
    char token;
    fd_set fds;
    int pingpipe[2], pongpipe[2];
    int reaped_ping, reaped_pong, ret;
    pid_t p, pingpid, pongpid, status;
    struct timeval tv;
    struct itimerval itimer;

    reaped_ping = reaped_pong = 0;

    // Create the two pipes
    if (pipe(pingpipe) || pipe(pongpipe)) {
        fprintf(stderr, "pingpong: unable to create pipes %s\n",
                strerror(errno));
    }

    // Step 1: register a signal handler to catch child exits
    // Do this before we fork off the children.
    signal(SIGCHLD, child_handler);

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
    // exit or 5 seconds; whichever is shorter.
    start_time = timestamp();
    // Set up the timeout (5 seconds)
    tv.tv_usec = 0;
    tv.tv_sec = 5;

    // Set up the file descriptros -- we are interested in the read descriptor
    FD_SET(signalpipe[0], &fds);

    // Now call select!  We have to figure out how many FDs we are sending -- 
    // since arrays start at 0, and the one we're waiting on is stored in the
    // pipe at signalpipe[0], the number of fds we have is 1 greater than the
    // value of that fd.
    ret = select(signalpipe[0] + 1, &fds, NULL, NULL, &tv);

    // So, when we wake up, we know that either our fd is ready for reading
    // or our timeout expired.
    printf("Select exited with %d\n", ret);

    // We can't try reading the pipe, because if we really timed out, we'd
    // end up hanging, so instead, let's check on the statuses of our children.
    // We want to reap their statuses anyway!
    p = waitpid(pingpid, &status, WNOHANG);
    if (p != pingpid && p != 0) {
        // Ping has not exited; kill it
        kill(pingpid, SIGINT);
    }
    p = waitpid(pongpid, &status, WNOHANG);
    if (p != pongpid && p != 0) {
        // Pong has not exited; kill it
        kill(pongpid, SIGINT);
    }
    printf("Parent exiting after %g sec\n", timestamp() - start_time);
}
