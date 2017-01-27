// These examples build on/mimic the multi-process ping pong program from
// lecture 18 and the select video. The challenge this time is to synchronize
// two pthreads who need to alternate printing out pings and pongs to the console.
//
// The main program creates two threads, each of whom uses the same function,
// but with a different argument. The argument indicates whether the thread
// is allowed to print on odd or even instances of a global variable. We'll
// start with an unsynchronized version and then try a variety of different
// approaches to synchronizing.

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// How many total pings and pongs we'll print
#define TOTAL_MSGS 50

// Structure that we'll use to transmit information
// to the threads.

struct pp_thread_info {
    int *msgcount;      // Keeps track of total number of messages; shared state
    pthread_mutex_t *mutex;
    char *msg;
    int modval;
};

// Unsynchronized version -- pings and pongs will not alternate nicely

// Thread function for both pings and pongs; the arg function will be 
// pointer to a struct pp_thread_info and carries all the information
// that the thread needs to process pings and pongs.

void *
pp_thread(void *arg)
{
    int c, done;
    struct pp_thread_info *infop;

    infop = arg;
    done = 0;
    while (1) {
        pthread_mutex_lock(infop->mutex);
        done = *infop->msgcount >= TOTAL_MSGS;
        if (*infop->msgcount % 2 == infop->modval) {
            printf("%s\n", infop->msg);
            c = *infop->msgcount;
            usleep(10);
            c = c + 1;
            *infop->msgcount = c;
        }
        pthread_mutex_unlock(infop->mutex);
        if (done)
            break;
    }

    return (NULL);
}

int
main(void)
{
    pthread_t ping_id1, pong_id1;
    pthread_t ping_id2, pong_id2;
    pthread_mutex_t mutex;
    struct pp_thread_info ping, pong;
    int msgcount;

    msgcount = 0;
    if (pthread_mutex_init(&mutex, NULL) != 0) {
        fprintf(stderr, "Pingpong: Mutex init failed %s\n", strerror(errno));
        exit(1);
    }

    ping.msgcount = &msgcount;
    ping.mutex = &mutex;
    ping.msg = "ping";
    ping.modval = 0;

    pong.msgcount = &msgcount;
    pong.mutex = &mutex;
    pong.msg = "pong";
    pong.modval = 1;

    // Create the two threads
    if ((pthread_create(&ping_id1, NULL, &pp_thread, &ping) != 0) ||
        (pthread_create(&pong_id1, NULL, &pp_thread, &pong) != 0) ||
        (pthread_create(&ping_id2, NULL, &pp_thread, &ping) != 0) ||
        (pthread_create(&pong_id2, NULL, &pp_thread, &pong) != 0)) {
        fprintf(stderr, "pingpong: pthread_create failed %s\n", strerror(errno));
        exit(1);
    }

    // Now wait for threads to exit (Probably should check for errors)
    pthread_join(ping_id1, NULL);
    pthread_join(pong_id1, NULL);
    pthread_join(ping_id2, NULL);
    pthread_join(pong_id2, NULL);

    pthread_mutex_destroy(&mutex);

    printf("Main thread exiting\n");

}

