#include <signal.h>
#include <stdio.h>
#include <unistd.h>

sig_atomic_t stop = 0;

void handler(int signo) {
    stop = 1;
}

int main() {
    signal(SIGINT, handler);

    while (1) {
        if (stop == 1) {
            printf("You tried to stop me!!!!!\n");
        } else { 
            printf("I can live forever!!!\n");
        }
        sleep(1);
    }
    return 0;
}
