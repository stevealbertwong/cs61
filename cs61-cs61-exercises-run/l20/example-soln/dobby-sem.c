// Solves the dobby-the-elf and the house elf problem

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "pt61_sem.h"

#define NELVES 25
#define RANDOM_INT(lo, hi) ((int)(lo + ((double)random() / RAND_MAX) * (hi - lo + 1)))

pt61_sem dobby_sem;


// The argument is simply the elf's ID number
void *
elf_thread(void *arg)
{
    int id;

    id = (int)arg;

    // Prepare sumptious feast
    usleep(RANDOM_INT(20,30));
    printf("Elf %d prepared sumptious feast!\n", id);
  
    // Clean up after messy Hogwarts students
    usleep(RANDOM_INT(10,20));
    printf("Elf %d cleaned up after messy students!\n", id);
   
    // Say, "Harry Potter is the greatest Wizard Ever."
    usleep(RANDOM_INT(1,100));
    printf("Elf %d: Harry Potter is the greatest Wizard Ever!\n", id);

    // Before exiting, V Dobby's scheduling semaphore so Dobby knows
    // that we've finished.
    pt61_sem_V(dobby_sem);
    return (NULL);
}

int
main(void)
{
    pthread_t *thread_ids;

    // Initialize the dobby scheduling semaphore.
    if (pt61_sem_create(&dobby_sem, 0) != 0) {
    	fprintf(stderr, "Dobby: Sem create failed %s\n", strerror(errno));
	exit (1);
    }

    // Create the elf threads -- malloc space to capture their IDs because
    // we'll check that they all exited at the end.
    thread_ids = malloc(sizeof(pthread_t) * NELVES);
    if (thread_ids == NULL) {
        fprintf(stderr, "Dobby: Malloc of elf thread ids failed %s\n", strerror(errno));
        exit (1);
    }

    for (long long i = 0; i < NELVES; i++) {
        if (pthread_create(thread_ids + i, NULL, &elf_thread, (void *)i) != 0) {
            fprintf(stderr, "Dobby: pthread_create %lld failed %s\n", i, strerror(errno));
            exit(1);
        }
    }

    for (int i = 0; i < NELVES; i++) {
        pt61_sem_P(dobby_sem);
        printf("Thanks for your work, Elf!\n");
    }

    free(thread_ids);

    printf("Dobby is done\n");
}

