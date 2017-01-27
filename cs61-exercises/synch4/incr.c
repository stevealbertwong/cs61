//! -O0
#include <pthread.h>
#include <stdio.h>

void* threadfunc(void* arg) {
    unsigned* x = (unsigned*) arg;
    for (int i = 0; i != 10000000; ++i)
        ++*x;
    return 0;
}

int main() {
    pthread_t th[4];
    unsigned n = 0;
    for (int i = 0; i != 4; ++i)
        pthread_create(&th[i], NULL, threadfunc, (void*) &n);
    for (int i = 0; i != 4; ++i)
        pthread_join(th[i], NULL);
    printf("%u\n", n);
}
