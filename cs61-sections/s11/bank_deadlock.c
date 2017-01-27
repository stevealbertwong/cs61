#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bank.h"

// Contains the amount of money in each account -- overdrafts allowed
volatile int accounts[NACCOUNTS];

// Fine grained locks for each account
pthread_mutex_t locks[NACCOUNTS];

void bank_deposit(int acct, int amount) {
    assert(acct >= 0 && acct < NACCOUNTS);

    pthread_mutex_lock(&locks[acct]);
    accounts[acct] += amount;
    pthread_mutex_unlock(&locks[acct]);
}

void bank_withdraw(int acct, int amount) {
    assert(acct >= 0 && acct < NACCOUNTS);

    pthread_mutex_lock(&locks[acct]);
    accounts[acct] -= amount;
    pthread_mutex_unlock(&locks[acct]);
}

void bank_transfer(int acct1, int acct2, int amount) {
    assert(acct1 >= 0 && acct1 < NACCOUNTS);
    assert(acct2 >= 0 && acct2 < NACCOUNTS);

    // Potential Deadlock:
    // Suppose TRANSFER A B and TRANSFER B A occur concurrently.
    // Thread 1 locks A, Thread 2 locks B.
    // Both wait forever for the other to give up the other lock
    pthread_mutex_lock(&locks[acct1]);
    pthread_mutex_lock(&locks[acct2]);

    accounts[acct1] -= amount;
    accounts[acct2] += amount;

    pthread_mutex_unlock(&locks[acct2]);
    pthread_mutex_unlock(&locks[acct1]);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s NTHREADS\n", argv[0]);
        exit(1);
    }

    for (int i = 0; i < NACCOUNTS; ++i)
        pthread_mutex_init(&locks[i], NULL);

    // Start a new thread for each trace
    int nthreads = atoi(argv[1]);
    assert(nthreads > 0 && nthreads <= 32);

    // Run all 32 traces, no more than `nthreads` at a time
    pthread_t threads[NTRACES];
    for (int i = 0; i < nthreads; ++i) {
        bank_thread_args* args =
            (bank_thread_args*) malloc(sizeof(bank_thread_args));
        args->index = i;
        args->nthreads = nthreads;
        pthread_create(&threads[i], NULL, bank_thread_start, args);
    }

    // Wait for all the threads to exit
    for (int i = 0; i < nthreads; ++i)
        pthread_join(threads[i], NULL);

    // Print out final bank amounts
    for (int i = 0; i < NACCOUNTS; ++i)
        printf("accounts[%d]: %d\n", i, accounts[i]);

    for (int i = 0; i < NACCOUNTS; ++i)
        pthread_mutex_destroy(&locks[i]);
}
