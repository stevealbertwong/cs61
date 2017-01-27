#ifndef CS61_GC61_H
#define CS61_GC61_H
#include <stddef.h>

void *m61_malloc(size_t sz);
void m61_free(void* ptr);

extern char* stack_bottom;
void m61_print_allocations(int);
void m61_find_allocations(char* base, size_t sz);
void m61_gc(void);

#endif
