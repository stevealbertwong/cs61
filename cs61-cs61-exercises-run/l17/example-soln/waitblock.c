#include "helpers.h"

void signal_handler(int signal) {
    (void) signal;
}

int main(void) {
    int ret;
    pid_t p1;

    fprintf(stderr, "Hello from parent pid %d\n", getpid());

    // Demand that SIGCHLD interrupt system calls
    ret = handle_signal(SIGCHLD, signal_handler);
    assert(ret >= 0);

    // Start a child
    p1 = nfork();
    assert(p1 >= 0);
    if (p1 == 0) {
        usleep(500000);
        fprintf(stderr, "Goodbye from child pid %d\n", getpid());
        exit(0);
    }
    double start_time = timestamp();

    // Wait for the child and print its status
    ret = usleep(750000);
    if (ret == -1 && errno == EINTR)
        fprintf(stderr, "usleep interrupted by signal after %g sec\n",
                timestamp() - start_time);
    else
        fprintf(stderr, "Child timed out\n");
}
