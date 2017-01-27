#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_COUNT 10000000

typedef struct mutex {
    // Your code here!
} mutex;

void mutex_init(mutex* m) {
    // Your code here!
}

void mutex_acquire(mutex* m) {
    // Your code here!
}

void mutex_release(mutex* m) {
    // Your code here!
}

char the_best[100];
mutex lock;

void* tom_thread(void* arg) {
    (void) arg;
    int count = 0;
    while (count < MAX_COUNT) {
        strcpy(the_best, "Tom is the best!");
        ++count;
    }
    return NULL;
}

void* ginny_thread(void* arg) {
    (void) arg;
    int count = 0;
    while (count < MAX_COUNT) {
        strcpy(the_best, "Ginny is the best!");
        ++count;
    }
    return NULL;
}

int main() {
    pthread_t tom;
    pthread_t ginny;

    assert(pthread_create(&tom, NULL, tom_thread, NULL) == 0);
    assert(pthread_create(&ginny, NULL, ginny_thread, NULL) == 0);

    int count = 0;
    while (count < MAX_COUNT) {
        printf("%s\n", the_best);
        ++count;
    }

    assert(pthread_join(tom, NULL) == 0);
    assert(pthread_join(ginny, NULL) == 0);
    return 0;
}
