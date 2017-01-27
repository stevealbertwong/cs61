#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

// Program to demonstrate various pipe behaviors.
// We will fork ourselves and then have two processes (parent and child)
// communicate via a pipe. We'll print messages to stderr so we can see
// them and try various things.
int
main(void)
{
    char c, *cp;
    char pidbuf[10];
    int pipebuf[2];
    pid_t   childpid, mypid;
    size_t n;

    // Introduce ourselves
    mypid = getpid();
    fprintf(stderr, "%d: I am the parent\n", mypid);

    // Create the pipe
    assert(pipe(pipebuf) == 0);

    // Now let's create the child
    childpid = fork();

    switch (childpid) {
        case 0: // child
            setpgid(0,0); // Put myself in a different process group

            // Introduce myself
            mypid = getpid();
            fprintf(stderr, "%d I am the child\n", mypid);

            // Adopt the reader end of the pipe
            // close(pipebuf[1]);
            dup2(pipebuf[0], STDIN_FILENO);

            // Now, we're just going to read from the pipe and write
            // to standard error until we get EOF
            while ((n = read(STDIN_FILENO, &c, 1)) == 1)
                write(STDERR_FILENO, &c, 1);

            break;
        case -1: // error
            break;
        default: // parent
            fprintf(stderr, "%d I parented child %d\n", mypid, childpid);
            // Now set up pipe for my STDOUT
            // close(pipebuf[0]);
            dup2(pipebuf[1], STDOUT_FILENO);
            while ((n = read(STDIN_FILENO, &c, 1)) == 1)
                write(STDOUT_FILENO, &c, 1);
            break;
    }
}

