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
pt61_sem elf_sem;	// For elf use; register ID # of exiting elf.
int *elf_ids = NULL;
int elf_ndx = 0;

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

    // Record our ID in the elf_id array.
    pt61_sem_P(elf_sem);
    elf_ids[elf_ndx++] = id;
    pt61_sem_V(elf_sem);

    // Before exiting, V Dobby's scheduling semaphore so Dobby knows
    // that we've finished.
    pt61_sem_V(dobby_sem);
    return (NULL);
}

int
main(void)
{
    int ret;
    pthread_t *thread_ids;

    ret = -1;
    thread_ids = NULL;

    // Initialize the dobby scheduling semaphore.
    if (pt61_sem_create(&dobby_sem, 0) != 0) {
    	fprintf(stderr, "Dobby: Sem create failed %s\n", strerror(errno));
	exit (1);
    }

    // Initialize the elf exit lock
    if (pt61_sem_create(&elf_sem, 1) != 0) {
    	fprintf(stderr, "Dobby: Sem create failed %s\n", strerror(errno));
	goto err;
    }

    // Malloc space to capture elf pthread IDs because
    // we'll check that they all exited at the end.
    if ((thread_ids = malloc(sizeof(pthread_t) * NELVES)) == NULL) {
        fprintf(stderr, "Dobby: Malloc of elf thread ids failed %s\n", strerror(errno));
        goto err2;
    }

    // Now malloc space for elves to report their ID on exit
    if ((elf_ids = malloc(sizeof(int) * NELVES)) == NULL) {
        fprintf(stderr, "Dobby: Malloc of elf ids failed %s\n", strerror(errno));
        goto err2;
    }

    // Now create the elves.
    for (long long i = 0; i < NELVES; i++) {
        if (pthread_create(thread_ids + i, NULL, &elf_thread, (void *)i) != 0) {
            fprintf(stderr, "Dobby: pthread_create %lld failed %s\n", i, strerror(errno));
            goto err2;
        }
    }

    // It is safe to access the elf_ids array without acquiring a lock,
    // because the entry is always filled before the V operation
    for (int i = 0; i < NELVES; i++) {
        pt61_sem_P(dobby_sem);
        printf("Thanks for your work, Elf %d!\n", elf_ids[i]);
    }
    printf("Dobby is done\n");
    ret = 0;

err2:
    if (thread_ids != NULL)
        free(thread_ids);
    if (elf_ids != NULL)
    	free (elf_ids);
    pt61_sem_destroy(elf_sem);
err:
    pt61_sem_destroy(dobby_sem);
    exit (ret);
}

