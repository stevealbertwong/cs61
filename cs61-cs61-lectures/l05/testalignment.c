#include <stdlib.h>
#include <inttypes.h>
#include <stdio.h>

int main() {
    int MAX_ALIGNMENT = 64;
    int histogram[MAX_ALIGNMENT];
    for (int i = 0; i < MAX_ALIGNMENT; ++i)
        histogram[i] = 0;

    int N = 100000;
    char** allocations = (char**) malloc(sizeof(char*) * N);
    for (int i = 0; i < N; ++i)
        allocations[i] = malloc(random() % 512);

    // Count the alignment mod 64 of each allocation
    // (so `histogram[x]` is the number of allocations where the address
    // of the allocation, mod 64, equals `x`)
    // Your code here

    // Print alignments
    for (int i = 0; i < MAX_ALIGNMENT; ++i)
        if (histogram[i])
            printf("%-10d%d\n", i, histogram[i]);

    for (int i = 0; i < N; ++i)
        free(allocations[i]);
    free(allocations);
}
