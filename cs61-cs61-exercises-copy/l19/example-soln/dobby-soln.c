// Solves the dobby-the-elf and the house elf problem

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define NELVES 6
#define RANDOM_INT(lo, hi) ((int)(lo + ((double)random() / RAND_MAX) * (hi - lo + 1)))

// One global mutex and CV used to synchronize
// I could have bundled these into a structure passed to the thread function, but
// decided to use globals to illustrate a different approach. In general, I prefer
// the encapsulation, but for a short program, the use of globals is probably OK.
pthread_mutex_t mutex;
pthread_cond_t cv;
int elves_exited;

typedef enum _elf_status { running, done, dismissed } elf_status;
elf_status *status;    // Keeps track of which elves have exited


// The argument is simply the elf's ID number
void *
elf_thread(void *arg)
{
    int id;

    id = (int) arg;

    // Prepare sumptious feast
    usleep(RANDOM_INT(20,30));
    printf("Elf %d prepared sumptious feast!\n", id);
  
    // Clean up after messy Hogwarts students
    usleep(RANDOM_INT(10,20));
    printf("Elf %d cleaned up after messy students!\n", id);
   
    // Say, "Harry Potter is the greatest Wizard Ever."
    usleep(RANDOM_INT(1,100));
    printf("Elf %d: Harry Potter is the greatest Wizard Ever!\n", id);

    pthread_mutex_lock(&mutex);
    status[id] = done;
    elves_exited++;
    pthread_cond_signal(&cv);
    pthread_mutex_unlock(&mutex);
    
    return (NULL);
}

int
main(void)
{
    int keep_running;
    pthread_t *thread_ids;

    if (pthread_mutex_init(&mutex, NULL) != 0) {
        fprintf(stderr, "Dobby: Mutex init failed %s\n", strerror(errno));
        exit(1);
    }
    if (pthread_cond_init(&cv, NULL) != 0) {
        fprintf(stderr, "Dobby: CV init failed %s\n", strerror(errno));
        exit(1);
    }

    // Create the elf threads -- malloc space to capture their IDs because
    // we'll check that they all exited at the end.
    thread_ids = malloc(sizeof(pthread_mutex_t) * NELVES);
    if (thread_ids == NULL) {
        fprintf(stderr, "Dobby: Malloc of elf thread ids failed %s\n", strerror(errno));
        exit (1);
    }
    status = malloc(sizeof(elf_status) * NELVES);
    if (status == NULL) {
        fprintf(stderr, "Dobby: Malloc of elf statuses failed %s\n", strerror(errno));
        exit (1);
    }

    elves_exited = 0;
    for (int i = 0; i < NELVES; i++) {
        if (pthread_create(thread_ids + i, NULL, &elf_thread, (void *)i) != 0) {
            fprintf(stderr, "Dobby: pthread_create %d failed %s\n", i, strerror(errno));
            exit(1);
        }
        status[i] = running;
    }

    // Now, wait until all the elves have finished.

    do {
        pthread_mutex_lock(&mutex);
        while (elves_exited == 0)
            pthread_cond_wait(&cv, &mutex);
        
        // Find elves who are done; dismiss them 
        keep_running = 0;
        for (int i = 0; i < NELVES; i++) {
            // Figure out when we're done
            if (status[i] == running)
                keep_running = 1;

            if (status[i] == done) {
                status[i] = dismissed;
                printf("Thanks for your work, Elf %d\n", i);
                pthread_join(thread_ids[i], NULL);
                elves_exited--;
            }
        }
        pthread_mutex_unlock(&mutex);
    } while (keep_running);

    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cv);
    free(thread_ids);
    free(status);

    printf("Dobby is done\n");
}

