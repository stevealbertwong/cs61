#include "gc61.h"
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

typedef struct memregion {
    char* ptr;
    size_t sz;
} memregion;

static memregion* mr;
static size_t nmr;
static size_t mr_capacity;
static size_t heap_active;
static void m61_mr_grow(void);

void* m61_malloc(size_t sz) {
    void* ptr = malloc(sz);
    if (ptr) {
        // keep track of allocated regions in `mr` array
        if (nmr == mr_capacity)
            m61_mr_grow();
        mr[nmr].ptr = ptr;
        mr[nmr].sz = sz;
        heap_active += sz;
        ++nmr;
    }
    return ptr;
}

void m61_free(void* ptr) {
    free(ptr);
}

void m61_print_allocations(void) {
}

void m61_find_allocations(char* base, size_t sz) {
    (void) base, (void) sz;
}

void m61_cleanup(void) {
}


static void m61_mr_grow(void) {
    mr_capacity = mr_capacity ? 2 * mr_capacity : 128;
    mr = (memregion*) realloc(mr, sizeof(memregion) * mr_capacity);
}
