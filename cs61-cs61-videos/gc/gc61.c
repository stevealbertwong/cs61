#include "gc61.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/*
 * This is a simple garbage collector for C programs.
 * We use the regular/standard malloc routines, but add
 * bookkeeping to keep track of allocated regions. We
 * then creep up the stack to find all live pointers so
 * we can free any non-live pointers.  This code implements
 * a traditional mark and sweep collector.
 */

/* This is the information we keep for each allocation. */
typedef struct memregion {
    char *ptr;
    size_t sz;
    int mark;	/* Used to mark in-use regions. */
} memregion;

/*
 * These variables are all the information that we need visible throughout
 * the garbage collector, but that we don't want users of the garbage collector
 * to see. If we made these global, then the users (callers) of our library
 * would have access to them; by making them static, only functions in this
 * file have access to them.
 */
static memregion *mr;		// Holds metadata for the entire region
static size_t nmr;		// Number of allocations currently in the region
static size_t mr_capacity;	// Maximum number of allocations the region can hold
static void m61_mr_grow(void);	// Function that will grow the region

char* stack_bottom;



void *
m61_malloc(size_t sz) {
    void *ptr;
    
    ptr = malloc(sz);
    if (ptr) {
        // keep track of allocated regions in `mr` array
        if (nmr == mr_capacity)
            m61_mr_grow();
        mr[nmr].ptr = ptr;
        mr[nmr].sz = sz;
	// We don't need to initialize mark as we always clear these before
	// we start gc.
        ++nmr;
    }
    return (ptr);
}






static memregion *
m61_find_mr(void *ptr) {
    size_t i;

    for (i = 0; i != nmr; ++i)
        if ((char *)ptr >= mr[i].ptr && (char *)ptr < mr[i].ptr + mr[i].sz)
            return (&mr[i]);
    return (NULL);
}






void
m61_free(void* ptr) {
    if (ptr) {
        memregion *m;

	m = m61_find_mr(ptr);
        assert(m);
        assert(m->ptr == ptr);
        free(ptr);

	// Move the last entry in the mr array into the position occupied
	// by this allocation and then decrement the total number of allocations.
        *m = mr[nmr - 1];
        --nmr;
    }
}







/* Display number of current allocations; with debugging, print them out. */
void
m61_print_allocations(int debug) {
    size_t i;

    printf("%zu allocations\n", nmr);
    if (debug) {
	    for (i = 0; i != nmr; ++i) {
		printf("  #%zu: %p: %zu bytes\n", i, mr[i].ptr, mr[i].sz);
	    }
    }
}







/*
 * Examine all of the memory in [base, base + sz).
 *
 * Find every pointer in that memory that was allocated by m61_malloc and
 * mark the allocation. Then recursively check that region and find any
 * pointers contained in it.
 */
void
m61_find_allocations(char* base, size_t sz) {
    memregion *m;
    size_t i;
    void *ptr;

    for (i = 0; i + sizeof(void *) - 1 < sz; ++i) {
        memcpy(&ptr, &base[i], sizeof(void *));
	if (ptr == NULL)
		continue;
	m = m61_find_mr(ptr);
        if (m && !m->mark) {
            m->mark = 1;
            m61_find_allocations(m->ptr, m->sz);
        }
    }
}






/*
 * Main function that invokes the mark and sweep collector.
 */
void
m61_gc(void) {
    char *stack_top;
    size_t i;

    /*
     * As this is the routine that is invoking garbage collection, it's local
     * variables are the last thing placed on the stack. If we take the address
     * of our first local variable, then we know that we just need to check the
     * stack between that address and what we stored in stack_bottom.
     */
    stack_top = (char*) &stack_top;

    /* Clear all the mark bits.  */
    for (i = 0; i != nmr; ++i)
        mr[i].mark = 0;

    /* Mark all the allocations. */
    m61_find_allocations(stack_top, stack_bottom - stack_top);

    /* Anything not marked can be freed. */
    for (i = 0; i != nmr; ++i)
        if (!mr[i].mark) {
            m61_free(mr[i].ptr);
            --i;
        }
}


/*
 * Increase the space available for storing allocations.
 */
static
void m61_mr_grow(void) {
    mr_capacity = mr_capacity ? 2 * mr_capacity : 128;
    mr = (memregion *) realloc(mr, sizeof(memregion) * mr_capacity);
}
