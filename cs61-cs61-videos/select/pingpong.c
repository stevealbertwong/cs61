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

// Unsynchronized version -- pings and pongs will not alternate nicely
int
main(void)
{
    pid_t p, pingpid, pongpid;
    int reaped_ping, reaped_pong, status;

    reaped_ping = reaped_pong = 0;

    // Set up ping process
     pingpid = fork();
     switch (pingpid) {
         case 0:
             // Child ping process
             while (1)
                 printf("ping\n");
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
             // Child pong process
             while (1)
                 printf("pong\n");
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
    while (!reaped_ping || !reaped_pong) {
        p = waitpid(-1, &status, 0);
        if (p == pingpid)
            reaped_ping = 1;
        if (p == pongpid)
            reaped_pong = 1;
    }
    printf("Parent exiting\n");

}
