#include <assert.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void handler(int signo) {
    /* Do nothing */
}

int main() {
    int pipefds[2];
    assert(pipe(pipefds) == 0);

    pid_t pid = fork();
    assert(pid != -1);

    // Child execution: bad child never writes to pipe!
    if (pid == 0) {
        while (1);
    }

    // Parent execution: set a signal handler for SIGALRM using sigaction.
    struct sigaction s;
    sigemptyset(&s.sa_mask);
    s.sa_flags = 0;
    s.sa_handler = handler;

    assert(sigaction(SIGALRM, &s, NULL) == 0);

    // Will receive a SIGALARM soon!
    alarm(2);

    char ch = '!';
    int err = read(pipefds[0], &ch, sizeof(char));
    if (err) {
        if (errno == EINTR) {
            printf("Parent gave up on waiting for the child! Killing child.\n");
            assert(kill(pid, SIGKILL) == 0);
            exit(1);
        }
    }

    // Had the child written something to the pipe, we'd see it...
    printf("%c\n", ch);
    return 0;
}
