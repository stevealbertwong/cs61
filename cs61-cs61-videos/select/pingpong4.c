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

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

// Let's now have the parent sleep for 5 seconds and then kill any children
// who are still running.

int
main(void)
{
    char token;
    int pingpipe[2], pongpipe[2];
    pid_t pingpid, pongpid, status;

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

    sleep(5);
    // Check if children are still running; kill if they are.
   
    if (waitpid(pingpid, &status, WNOHANG) == 0)
        kill(pingpid, SIGINT);

    if (waitpid(pongpid, &status, WNOHANG) == 0)
        kill(pongpid, SIGINT);

    printf("Parent exiting\n");
}
