#include "membench.h"
#include <stdlib.h>

#define MEMNODE_GROUPSIZE 4095

/*
 * The term arena is used to describe the memory that an allocator uses.
 * You will define an arena composed of a variable number of memnode
 * groups, where each memnode group is able to hold MEMNODE_GROUPSIZE
 * memnodes.
 *
 * We define these structures here.
 */

typedef struct memnode_group {
    struct memnode_group* next;
    memnode nodes[MEMNODE_GROUPSIZE];
} memnode_group;

struct memnode_arena {
    memnode_group* groups;
    // TODO Implement some way to keep track of free memnodes here.
};

/*
 * This function should initialize the data structures that you need
 * to represent the arena, initializing all necessary fields.
 */
memnode_arena* memnode_arena_new(void) {
    // TODO -- Allocate and initialize whatever structures you need
    // to create an empty arena.
    return NULL;
}

void memnode_arena_free(memnode_arena* arena) {
    // TODO Clean up your arena, being sure to free any space you allocated
}

memnode* memnode_alloc(memnode_arena* arena) {
    // TODO: Here are the guts of the allocator!
    return NULL;
}

void memnode_free(memnode_arena* arena, memnode* m) {
    // TODO: And here is the place where you have to free stuff!
}
