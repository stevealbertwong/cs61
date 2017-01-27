#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

// Template to practice redirecting files.
// Take a cat-friendly command line, redirect standard output to the
// file cat.out and exec cat.

const char *outfile = "cat.out";

int
main(int argc, char *argv[])
{
    int fd, r;
    fprintf(stderr, "I am the parent, my pid is %d and my pgid is %d\n",
           getpid(), getpgid(0));

    // Redirecting STDOUT_FILENO requires that we have a file
    // descriptor to which we can redirect, so we should open
    // it here.
    fd = open(outfile, O_CREAT | O_WRONLY, 0644);
    if (fd < 0) {
        fprintf(stderr, "open: %s\n", strerror(errno));
        return (1);
    }

    // OK -- you add code here to redirect STDOUT_FILENO to this file
    if (dup2(fd, STDOUT_FILENO) < 0) {
        fprintf(stderr, "dup2: %s\n", strerror(errno));
        return (1);
    }

    // Pipe hygiene goes here!
    close(fd);

    // Now, change the first element of argv
#ifdef PART2
    pid_t p = fork();
    switch (p) {
        default: // Parent
            // sleep(100);
            return(0);
        case -1: // Error
            fprintf(stderr, "fork: %s\n", strerror(errno));
            return (-1);
        case 0:
            fprintf(stderr, "I am the child, my pid is %d and my pgid is %d\n",
                getpid(), getpgid(0));
#endif

    assert(strlen(argv[0]) > strlen("cat"));
    strcpy(argv[0], "cat");
    r = execvp("cat", argv);

#ifdef PART2
    }
#endif
    // Should never get here
    fprintf(stderr, "execvp: %s\n", strerror(errno));
    return (1);
}
