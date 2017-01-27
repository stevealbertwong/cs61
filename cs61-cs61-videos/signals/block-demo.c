#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int do_block = 0;
int signum;

void
hup_handler(int sig) {
    signum = sig;
}

void
int_handler(int sig) {
    signum = sig;
    do_block = !do_block;
}

int
main() {
    sigset_t signal_set;

    // Install signal handler.
    signal(SIGHUP, hup_handler);
    signal(SIGINT, int_handler);

    sigemptyset(&signal_set);
    sigaddset(&signal_set, SIGHUP);

    while (1) {
        if (do_block)
            sigprocmask(SIG_BLOCK, &signal_set, NULL);
        else
            sigprocmask(SIG_UNBLOCK, &signal_set, NULL);
        sleep(1000);
        printf("Process received signal %d\n", signum);
    }
}
