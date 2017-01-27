#include "iobench.h"

int cache_file_open(const char *, int);
int cache_file_read(int, void *, size_t);
void cache_read_block(int, void  *, size_t, size_t);
void cache_stats(void);
