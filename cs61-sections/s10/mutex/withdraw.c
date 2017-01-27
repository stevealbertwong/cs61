#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int balance;
//pthread_mutex_t mutex;

int get_balance() {
    return balance;
}

void set_balance(int val) {
    balance = val;
}

void* atm_A_thread(void* arg) {
    int* cash = arg;
//  pthread_mutex_lock(&mutex);

    int b = get_balance();
    if (b >= 500) {
        set_balance(b - 500);
        *cash = 500;
    } else {
        *cash = 0;
    }

//  pthread_mutex_unlock(&mutex);
    return NULL;
}

void* atm_B_thread(void* arg) {
    int* cash = arg;
//  pthread_mutex_lock(&mutex);

    int b = get_balance();

    // ATM B is a bit slower...
    usleep(1);

    if (b >= 300) {
        set_balance(b - 300);
        *cash = 300;
    } else {
        *cash = 0;
    }

//  pthread_mutex_unlock(&mutex);
    return NULL;
}

int main() {
//  pthread_mutex_init(&mutex, NULL);

    pthread_t atm_A;
    pthread_t atm_B;

    // Initial balance is 500.
    set_balance(500);

    // Create two ATM threads, which will set the amount of cash they give out
    // in cash_A and cash_B.
    int cash_A, cash_B;
    assert(pthread_create(&atm_A, NULL, atm_A_thread, &cash_A) == 0);
    assert(pthread_create(&atm_B, NULL, atm_B_thread, &cash_B) == 0);

    // Wait for ATM threads to finish!
    assert(pthread_join(atm_A, NULL) == 0);
    assert(pthread_join(atm_B, NULL) == 0);

    printf("Balance is: %d, Cash Received is: %d\n", balance, cash_A + cash_B);

//  pthread_mutex_destroy(&mutex);
    return 0;
}
