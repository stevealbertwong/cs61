#include <stdlib.h>
#include <inttypes.h>
#include <stdio.h>

/*
 * We are going to assume that alignments are a power of 2, because all
 * things digital are powers of 2.  Now, let's pick a maximum power of
 * 2 that we believe the alignment must be less than -- let's say 2^10 --
 * we can't possibly require more than 1 KB alignment.
 * */
#define NUM_POWERS 11
#define NALLOCATIONS 100000

int main() {
    char *p;
    int i, j;
    int histogram[NUM_POWERS];
    size_t max, size;

    for (i = 0; i < NUM_POWERS; ++i)
        histogram[i] = 0;

    /*
     * Now, allocate NALLOCATIONS of some random size less than 1 KB and
     * for each, find the maximum power of 2 to which it's aligned.
     */
    for (i = 0; i < NALLOCATIONS; ++i) {
        p = malloc(random() % 1024);
        max = size = 1;
        for (j = 0; j < NUM_POWERS; j++) {
            if ((uintptr_t)p % size == 0)
                    max = j;
            size <<= 1;
        }
        histogram[max]++;
    }

    /* Print alignments */
    for (i = 0, size = 1; i < NUM_POWERS; ++i, size <<= 1)
            printf("%-10zu%d\n", size, histogram[i]);

}
