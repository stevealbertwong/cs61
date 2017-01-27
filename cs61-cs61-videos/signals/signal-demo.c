#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int signal_received;

void
int_handler(int sig) {
    signal_received = sig;
}

int
main() {
    // Install signal handler.
    signal(SIGINT, int_handler);

    while (1) {
        sleep(2);
        printf("Process woke up, signal_received=%d\n", signal_received);
        signal_received = 0;
    }
}
