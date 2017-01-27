// One can implement different synchronization primitives in terms of other
// primitives (suggesting that perhaps the term primitive is in appropriate).
// In this example, we'll use pthread mutexes and CVs to implement semaphores.
// There are a number of ways we could do this; this is perhaps the simplest.

#include <assert.h>
#include <stdlib.h>
#include "pt61_sem.h"

struct _sem  {
    // XXX What fields to we need in a semaphore structure?
    int x; // Place holder because you can't have a 0-size structure
};

int
pt61_sem_create(pt61_sem *sp, int n)
{
    pt61_sem sem;

    if ((sem = (pt61_sem)malloc(sizeof(struct _sem))) == NULL)
        return (-1);

    // How do we initialize the fields of the semaphore structure?
    // Our code start

    // Our code done
    
    *sp = sem;
    return (0);

    // Don't forget error handling!
err2:
err:
    free(sem);
    return (-1);
}


void
pt61_sem_destroy(pt61_sem sem)
{
    // What is our cleanup?
}

void
pt61_sem_P(pt61_sem sem)
{
    // Implement P here
}

void
pt61_sem_V(pt61_sem sem)
{
    // Implement V here
}
