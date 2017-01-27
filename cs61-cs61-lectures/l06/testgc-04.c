#include "gc61.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <sys/resource.h>
#define m61_free(x)

static void benchmark(unsigned noperations, unsigned nslots) {
    void** allocations = (void**) m61_malloc(sizeof(void*) * nslots);
    for (unsigned s = 0; s != nslots; ++s)
        allocations[s] = NULL;

    // make `noperations` allocations of 1-4K each
    for (unsigned i = 0; i != noperations; ++i) {
        if (i % 100000 == 0 && i != 0)
            fprintf(stderr, "Allocation %u/%u\n", i, noperations);
        unsigned s = random() % nslots;
        m61_free(allocations[s]);
        size_t sz = 1024 + random() % 3072;
        allocations[s] = m61_malloc(sz);
        memset(allocations[s], 0, sz);
    }

    // print active allocations
    m61_print_allocations();
    m61_find_allocations((char*) &allocations[0], sizeof(void*) * nslots);

    // clean up
    for (unsigned s = 0; s != nslots; ++s)
        m61_free(allocations[s]);
    m61_free(allocations);
}

int main(int argc, char** argv) {
    stack_bottom = (char*) &argc;
    struct rlimit rlim;
    getrlimit(RLIMIT_AS, &rlim);
    rlim.rlim_cur = 10000000;
    setrlimit(RLIMIT_AS, &rlim);

    unsigned noperations = 1000000;
    if (argc >= 2)
        noperations = strtoul(argv[1], NULL, 0);
    unsigned nslots = 1000;
    if (argc >= 3)
        nslots = strtoul(argv[2], NULL, 0);

    benchmark(noperations, nslots);

    m61_cleanup();
    fprintf(stderr, "After cleanup...\n");
    // this should print nothing
    m61_print_allocations();
}
