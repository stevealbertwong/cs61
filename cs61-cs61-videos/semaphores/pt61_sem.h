// Include file to let programs use pt61 semaphores.
#include <pthread.h>

typedef struct _sem *pt61_sem;

int pt61_sem_create(pt61_sem *, int);
void pt61_sem_destroy(pt61_sem);

void pt61_sem_P(pt61_sem);
void pt61_sem_V(pt61_sem);

