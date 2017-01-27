#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bank.h"

// Contains the amount of money in each account -- overdrafts allowed
volatile int accounts[NACCOUNTS];

// Coarse grained lock to protect all the accounts
pthread_mutex_t big_lock;

void bank_deposit(int acct, int amount) {
    assert(acct >= 0 && acct < NACCOUNTS);

    pthread_mutex_lock(&big_lock);
    accounts[acct] += amount;
    pthread_mutex_unlock(&big_lock);
}

void bank_withdraw(int acct, int amount) {
    assert(acct >= 0 && acct < NACCOUNTS);

    pthread_mutex_lock(&big_lock);
    accounts[acct] -= amount;
    pthread_mutex_unlock(&big_lock);
}

void bank_transfer(int acct1, int acct2, int amount) {
    assert(acct1 >= 0 && acct1 < NACCOUNTS);
    assert(acct2 >= 0 && acct2 < NACCOUNTS);

    pthread_mutex_lock(&big_lock);
    accounts[acct1] -= amount;
    accounts[acct2] += amount;
    pthread_mutex_unlock(&big_lock);
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s NTHREADS\n", argv[0]);
        exit(1);
    }

    pthread_mutex_init(&big_lock, NULL);

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

    pthread_mutex_destroy(&big_lock);
}
