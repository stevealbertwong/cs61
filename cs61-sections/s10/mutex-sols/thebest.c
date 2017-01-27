#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define MAX_COUNT 100000

#define READ_MUTEX
//#define ZOMBIE_MUTEX

#ifdef READ_MUTEX
typedef struct mutex {
    int acquire_pipe[2];
    int release_pipe[2];
} mutex;

void mutex_init(mutex* m) {
    pipe(m->acquire_pipe);
    pipe(m->release_pipe);
    pid_t pid = fork();

    // Child execution.
    if (pid == 0) {
        // Pipe hygiene.
        close(m->acquire_pipe[0]); 
        close(m->release_pipe[1]); 

        char ch = '!';
        while (1) {
  	    // For full correctness, write/read should be in a loop.
            write(m->acquire_pipe[1], &ch, 1); 
            ssize_t r = read(m->release_pipe[0], &ch, 1);

            if (r == 0) {
                exit(0);
  	        }
        }
    } else {
        // Parent execution; pipe hygiene.
        close(m->acquire_pipe[1]);
        close(m->release_pipe[0]);
    }
}

void mutex_acquire(mutex* m) {
    char ch;
    read(m->acquire_pipe[0], &ch, 1);
}

void mutex_release(mutex* m) {
    char ch = '!';
    write(m->release_pipe[1], &ch, 1);
}
#endif

#ifdef ZOMBIE_MUTEX
typedef struct mutex {
    volatile pid_t pid;
} mutex;

void mutex_init(mutex* m) {
    m->pid = fork();
    if (m->pid == 0)
        exit(0);
}

void mutex_acquire(mutex* m) {
    int s;
    while (waitpid(m->pid, &s, 0) == -1);

    m->pid = fork();
    if (m->pid == 0) {
        while (1);
    }
}

void mutex_release(mutex* m) {
    kill(m->pid, SIGKILL);
}
#endif

char the_best[100];
mutex lock;

void* tom_thread(void* arg) {
    (void) arg;
    int count = 0;
    while (count < MAX_COUNT) {
        mutex_acquire(&lock);
        strcpy(the_best, "Tom is the best!");
        mutex_release(&lock);
        ++count;
    }
    return NULL;
}

void* ginny_thread(void* arg) {
    (void) arg;
    int count = 0;
    while (count < MAX_COUNT) {
        mutex_acquire(&lock);
        strcpy(the_best, "Ginny is the best!");
        mutex_release(&lock);
        ++count;
    }
    return NULL;
}

int main() {
    mutex_init(&lock);

    pthread_t tom;
    pthread_t ginny;

    assert(pthread_create(&tom, NULL, tom_thread, NULL) == 0);
    assert(pthread_create(&ginny, NULL, ginny_thread, NULL) == 0);

    int count = 0;
    while (count < MAX_COUNT) {
        mutex_acquire(&lock);
        printf("%s\n", the_best);
        fflush(stdout);
        mutex_release(&lock);
        ++count;
    }

    assert(pthread_join(tom, NULL) == 0);
    assert(pthread_join(ginny, NULL) == 0);
    return 0;
}
