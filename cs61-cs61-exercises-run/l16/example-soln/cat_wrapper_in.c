#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

// Template to practice redirecting files.
// Take a cat-friendly command line, redirect standard input to the
// file cat.out and exec cat. (cat.out should contain something if you
// already ran the cat_wrapper_out)

const char *infile = "cat.out";

int
main(int argc, char *argv[])
{
    int fd, r;
    // Redirecting STDIN_FILENO requires that we have a file
    // descriptor to which we can redirect, so we should open
    // it here.
    fd = open(infile, O_RDONLY);
    if (fd < 0) {
        fprintf(stderr, "open: %s\n", strerror(errno));
        return (1);
    }

    // OK -- you add code here to redirect STDIN_FILENO to this file
    if (dup2(fd, STDIN_FILENO) < 0) {
        fprintf(stderr, "dup2: %s\n", strerror(errno));
        return (1);
    }

    // FD hygiene goes here!
    close(fd);

    // Now, change the first element of argv
    assert(strlen(argv[0]) > strlen("cat"));
    strcpy(argv[0], "cat");
    r = execvp("cat", argv);

    // Should never get here
    fprintf(stderr, "execvp: %s\n", strerror(errno));
    return (1);
}
