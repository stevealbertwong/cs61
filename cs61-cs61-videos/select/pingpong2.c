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
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

// Synchronize using two pipes

int
main(void)
{
    char token;
    int p, pingpipe[2], pongpipe[2];
    int reaped_ping, reaped_pong;
    pid_t pingpid, pongpid, status;

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
             while (1) {
                 read(pingpipe[0], &token, 1);
                 printf("ping\n");
                 write(pongpipe[1], &token, 1);
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
                 read(pongpipe[0], &token, 1);
                 printf("pong\n");
                 write(pingpipe[1], &token, 1);
             }
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
    while (!reaped_ping || !reaped_pong) {
        p = waitpid(-1, &status, 0);
        if (p == pingpid)
            reaped_ping = 1;
        if (p == pongpid)
            reaped_pong = 1;
    }
    printf("Parent exiting\n");
}
