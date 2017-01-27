#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include "pt61_sem.h"

// Implementation of the dining philosopher's problem
// We'll set this up so that the philosophers are numbered 0-(N-1) and a philosopher, Pi,
// has a fork on the left numbered i and a fork on the right numbered (i+1) mod N 

#define NPhilosophers 5
#define RANDOM_INT(lo, hi) ((int)(lo + ((double)random() / RAND_MAX) * (hi - lo + 1)))

// State and primitives:
// status: what is the philosopher doing? 
// mutex: provide mutual exclusion to change philosopher states
// eating: semaphores -- one for each philosopher -- scheduling semaphore

typedef enum { THINKING, HUNGRY, EATING } pstate;
pstate status[NPhilosophers];
pt61_sem eating[NPhilosophers];

pthread_mutex_t mutex;

void
print_status(void)
{
	for (int i = 0; i < NPhilosophers; i++)
	    printf("%d ", status[i]);
	printf("\n");
}

// A philosopher can eat only if HUNGRY and neither philosopher
// on either side is already EATING.
void
can_eat(int id)
{
    if (status[id] == HUNGRY && 
        status[(id + NPhilosophers - 1) % NPhilosophers] != EATING &&
        status[(id + 1) % NPhilosophers] != EATING) {
	// We can eat!
	status[id] = EATING;
	pt61_sem_V(eating[id]);		// V this, so when the philosopher P's
    }
}


// We set our status to Hungry and then check if we can eat.
// Upon return, if chopsticks are available, we'll successfully P our
// eating mutex, but if they are not available, we'll block
void
get_forks(int id)
{
    pthread_mutex_lock(&mutex);
    status[id] = HUNGRY;
    can_eat(id); 
    pthread_mutex_unlock(&mutex);
    pt61_sem_P(eating[id]);
}

// When we're done, check if our putting down chopsticks
// will allow either of our neighbors to eat.
void
put_forks(int id)
{
    pthread_mutex_lock(&mutex);
    status[id] = THINKING;
    can_eat((id + NPhilosophers - 1) % NPhilosophers);
    can_eat((id + 1) % NPhilosophers);
    pthread_mutex_unlock(&mutex);
}

void *
philosopher(void *arg)
{
    int id;

    id = (int)(arg);
    printf("Philosopher %d starting up\n", id);

    while (1) {
        // We simulate both thinking and eating with Sleeping
	printf("Philosopher %d is thinking\n", id);
	// print_status();
        usleep(RANDOM_INT(10, 100));

	get_forks(id);
	printf("Philosopher %d is eating\n", id);
	// print_status();
        usleep(RANDOM_INT(10, 100));
	put_forks(id);
    }
}

int
main(void)
{
    pthread_t ids[NPhilosophers];
    pthread_mutex_t main_mutex;
    pthread_cond_t main_cv;
    struct timeval tv;
    struct timespec ts;

    // Create mutex and CV on which we'll block
    if (pthread_mutex_init(&main_mutex, NULL) != 0) {
        fprintf(stderr, "Philosophers: Mutex init failed %s\n", strerror(errno));
        exit(1);
    }
    if (pthread_cond_init(&main_cv, NULL) != 0) {
        fprintf(stderr, "Philosophers: CV init failed %s\n", strerror(errno));
        exit(1);
    }

    // Now create a mutex for the philosophers to use
    if (pthread_mutex_init(&mutex, NULL) != 0) {
        fprintf(stderr, "Philosophers: Mutex init failed %s\n", strerror(errno));
        exit(1);
    }

    // Create philosopher semaphores; these are scheduling semaphores so we
    // initialize them to 0
    for (int i = 0; i < NPhilosophers; i++) {
        if (pt61_sem_create(eating+i, 0) != 0) {
            fprintf(stderr, "Philosophers: Semaphore create failed %s\n",
		strerror(errno));
	    exit(1);
        }
    }

    // Spawn philosopher threads
    for (long long i = 0; i < NPhilosophers; i++) {
        if (pthread_create(ids + i, NULL, philosopher, (void *)i) != 0) {
	    fprintf(stderr, "Philosophers: Thread create failed %s\n",
	        strerror(errno));
	    exit (1);
	}
    }

    // We'll do a timed wait and then kill all the philosophers (how brutal)
    gettimeofday(&tv, NULL);
    ts.tv_nsec = 0;
    ts.tv_sec = tv.tv_sec + 1;
    if (pthread_cond_timedwait(&main_cv, &main_mutex, &ts) != 0)
        fprintf(stderr, "Philosophers: Timed wait error %s\n", strerror(errno));

    // Be tidy -- kill philosophers
    for (long long i = 0; i < NPhilosophers; i++)
        pthread_kill(ids[i], SIGINT);

    exit(1);
}
