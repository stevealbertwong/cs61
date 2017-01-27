#include "gc61.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <sys/resource.h>
#define m61_free(ptr) /* nothing! */

static void
benchmark(unsigned noperations, unsigned nslots) {
    size_t sz;
    unsigned i, s;
    void** allocations;
    
    allocations = (void **)m61_malloc(sizeof(void*) * nslots);

    for (s = 0; s != nslots; ++s)
        allocations[s] = NULL;

    // make `noperations` allocations of 1-4K each
    for (i = 0; i != noperations; ++i) {
	// Output a message every 100,000 allocations
        if (i % 100000 == 0 && i != 0)
            printf("Allocation %u/%u\n", i, noperations);

        s = random() % nslots;
        // m61_free(allocations[s]);
	sz = 1024 + random() % 3072;
        allocations[s] = m61_malloc(sz);
        memset(allocations[s], 0, sz);	// Zero out the memory we allocated.
    }

    m61_print_allocations(0);
    // m61_find_allocations((char*) &allocations[0], sizeof(void*) * nslots);

    // clean up -- free all our memory
    for (s = 0; s != nslots; ++s)
        m61_free(allocations[s]);
    m61_free(allocations);
}

int
main(int argc, char** argv) {
    extern char *stack_bottom;
    unsigned noperations, nslots;

    /*
     * The arguments to main got pushed on the stack.  We
     * can use the address of argc, the first argument, to
     * mark the bottom of the stack, because there can't be
     * any pointers to allocated memory before main gets called.
     */
    stack_bottom = (char *)&argc;

    noperations = 1000000;
    if (argc >= 2)
        noperations = strtoul(argv[1], NULL, 0);

    nslots = 2048;
    if (argc >= 3)
        nslots = strtoul(argv[2], NULL, 0);

    benchmark(noperations, nslots);

    m61_gc();

    // this should print "0 allocations"
    m61_print_allocations(0);
}
