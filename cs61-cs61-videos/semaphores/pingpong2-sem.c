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
    // What do I need here to synchronize?
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
        // How do I know when I can run?

        // Once you get here, you know you're OK to run.
        printf("%s\n", infop->msg);

        // What do I do after I run?
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

    // Create synchronization primitives and initialize the thread structures

    ping.msg = "ping";

    pong.msg = "pong";

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
    // Clean up synch primitives
err:
    if (pings != NULL)
        free(pings);
    if (pongs != NULL)
        free(pongs);
    return (ret);
}

