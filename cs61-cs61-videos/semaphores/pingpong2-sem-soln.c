// These examples build on/mimic the multi-process ping pong program from
// lecture 18 and the select video. The challenge this time is to synchronize
// two pthreads who need to alternate printing out pings and pongs to the
// console.
//
// The main program creates N threads of each type. We demonstrate the use
// of semaphores.

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "pt61_sem.h"

// How many pings and pongs each thread will try to print
#define TOTAL_MSGS 50

// Structure that we'll use to transmit information
// to the threads.

struct pp_thread_info {
    pt61_sem wait_sem;
    pt61_sem sig_sem;
    char *msg;
};

// Thread function for both pings and pongs; the arg function will be 
// pointer to a struct pp_thread_info and carries all the information
// that the thread needs to process pings and pongs.

void *
pp_thread(void *arg)
{
    struct pp_thread_info *infop;
    int i;

    infop = arg;
    for (i = 0; i < TOTAL_MSGS; i++) {
        pt61_sem_P(infop->wait_sem);

        // Once you get here, you know you're OK to run.
        printf("%s\n", infop->msg);
        pt61_sem_V(infop->sig_sem);
    }

    return (NULL);
}

// Usage: pingpong2-sem N
// N is the number of threads of each type to spawn
void
usage()
{
    fprintf(stderr, "Usage: pingpong2-sem N\n");
    exit (1);
}

int
main(int argc, char *argv[])
{
    int i, ret;
    long nthreads;
    pthread_t *pings;
    pthread_t *pongs;
    struct pp_thread_info ping, pong;

    ret = 1;
    if (argc < 2)
        usage();
    nthreads = strtoul(argv[1], NULL, 0);

    pings = pongs = 0;
    if ((pings = (pthread_t *)malloc(sizeof(pthread_t) * nthreads)) == NULL ||
        (pongs = (pthread_t *)malloc(sizeof(pthread_t) * nthreads)) == NULL)
        goto err;

    // Create semaphores
    if (pt61_sem_create(&ping.wait_sem, 1) != 0)
        goto err;

    if (pt61_sem_create(&pong.wait_sem, 0) != 0) {
        pt61_sem_destroy(ping.wait_sem);
        goto err;
    }

    ping.msg = "ping";
    ping.sig_sem = pong.wait_sem;

    pong.msg = "pong";
    pong.sig_sem = ping.wait_sem;

    // Create the threads
    for (i = 0; i < nthreads; i++) {
        if ((pthread_create(pings + i, NULL, &pp_thread, &ping) != 0) ||
            (pthread_create(pongs + i, NULL, &pp_thread, &pong) != 0)) {
            fprintf(stderr, "pingpong: pthread_create failed %s\n",
                    strerror(errno));
            goto err2;
        }
    }

    // Now wait for threads to exit (Probably should check for errors)
    for (i = 0; i < nthreads; i++) {
        pthread_join(pings[i], NULL);
        pthread_join(pongs[i], NULL);
    }

    printf("Main thread exiting\n");
    ret = 0;

err2:
    pt61_sem_destroy(ping.wait_sem);
    pt61_sem_destroy(pong.wait_sem);
err:
    if (pings != NULL)
        free(pings);
    if (pongs != NULL)
        free(pongs);
    return (ret);
}

