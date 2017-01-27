// One can implement different synchronization primitives in terms of other
// primitives (suggesting that perhaps the term primitive is in appropriate).
// In this example, we'll use pthread mutexes and CVs to implement semaphores.
// There are a number of ways we could do this; this is perhaps the simplest.

#include <assert.h>
#include <stdlib.h>
#include "pt61_sem.h"

struct _sem  {
    int val;    // Value of the semaphore.
    pthread_mutex_t mutex;
    pthread_cond_t  cv;
};

int
pt61_sem_create(pt61_sem *sp, int n)
{
    pt61_sem sem;

    if ((sem = (pt61_sem)malloc(sizeof(struct _sem))) == NULL)
        return (-1);

    sem->val = n;
    if (pthread_mutex_init(&sem->mutex, NULL) != 0)
            goto err;
    if (pthread_cond_init(&sem->cv, NULL) != 0)
            goto err2;

    *sp = sem;
    return (0);

err2:
    pthread_mutex_destroy(&sem->mutex);
err:
    free(sem);
    return (-1);
}


void
pt61_sem_destroy(pt61_sem sem)
{
    pthread_mutex_destroy(&sem->mutex);
    pthread_cond_destroy(&sem->cv);
    free(sem);
}

void
pt61_sem_P(pt61_sem sem)
{
    pthread_mutex_lock(&sem->mutex);
    while (sem->val <= 0)
        pthread_cond_wait(&sem->cv, &sem->mutex);

    // Once we get here, we know sem->val > 0
    assert(sem->val > 0);
    sem->val--;
    pthread_mutex_unlock(&sem->mutex);
}

void
pt61_sem_V(pt61_sem sem)
{
    pthread_mutex_lock(&sem->mutex);
    sem->val++;
    pthread_cond_broadcast(&sem->cv);
    pthread_mutex_unlock(&sem->mutex);
}
