#include <stdlib.h>
#include <inttypes.h>
#include <stdio.h>

unsigned gcd(uintptr_t a, uintptr_t b) {
    // Euclid's famous algorithm for GCD!
    // http://en.wikipedia.org/wiki/Greatest_common_divisor
    if (b == 0)
        return a;
    else
        return gcd(b, a % b);
}

int main() {
    int N = 100000;
    char** allocations = (char**) malloc(sizeof(char*) * N);
    for (int i = 0; i < N; ++i)
        allocations[i] = malloc(random() % 512);

    // Your code here: What alignment does each allocation have?
    uintptr_t alignment = (uintptr_t) allocations[0];
    for (int i = 1; i < N; ++i)
        alignment = gcd((uintptr_t) allocations[i], alignment);
    printf("%u\n", (unsigned) alignment);

    for (int i = 0; i < N; ++i)
        free(allocations[i]);
    free(allocations);
}
