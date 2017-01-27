// These examples build on/mimic the multi-process ping pong program from
// lecture 18 and the select video. The challenge this time is to synchronize
// two pthreads who need to alternate printing out pings and pongs to the console.
//
// The main program creates four threads (2 pings and 2 pongs). The threads are
// identical except for the messages they print and whether they print on even
// or odd messages.  We add an explicit usleep to trigger the race condition.

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
    pthread_cond_t *wait_cv;
    pthread_cond_t *signal_cv;
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
    struct pp_thread_info *infop;
    int c;

    infop = arg;
    while (*infop->msgcount < TOTAL_MSGS) {
        pthread_mutex_lock(infop->mutex);
        while (*infop->msgcount % 2 != infop->modval)
            pthread_cond_wait(infop->wait_cv, infop->mutex);

        // Once you get here, you know you're OK to run.
        printf("%s\n", infop->msg);
        c = *infop->msgcount;
        usleep(10);
        c = c + 1;
        *infop->msgcount = c;
        pthread_cond_signal(infop->signal_cv);
        pthread_mutex_unlock(infop->mutex);
    }

    return (NULL);
}

int
main(void)
{
    int msgcount;
    pthread_cond_t ping_cv, pong_cv;
    pthread_mutex_t mutex;
    pthread_t ping_id1, pong_id1;
    pthread_t ping_id2, pong_id2;
    struct pp_thread_info ping, pong;

    msgcount = 0;

    if (pthread_mutex_init(&mutex, NULL) != 0) {
        fprintf(stderr, "Pingpong: Mutex init failed %s\n", strerror(errno));
        exit(1);
    }
    if (pthread_cond_init(&ping_cv, NULL) != 0) {
        fprintf(stderr, "Pingpong: CV init failed %s\n", strerror(errno));
        exit(1);
    }
    if (pthread_cond_init(&pong_cv, NULL) != 0) {
        fprintf(stderr, "Pingpong: CV init failed %s\n", strerror(errno));
        exit(1);
    }

    ping.msgcount = &msgcount;
    ping.mutex = &mutex;
    ping.wait_cv = &ping_cv;
    ping.signal_cv = &pong_cv;
    ping.msg = "ping";
    ping.modval = 0;

    pong.msgcount = &msgcount;
    pong.mutex = &mutex;
    pong.wait_cv = &pong_cv;
    pong.signal_cv = &ping_cv;
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
    pthread_cond_destroy(&ping_cv);
    pthread_cond_destroy(&pong_cv);

    printf("Main thread exiting\n");
}

