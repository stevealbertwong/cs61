#ifndef CS61_FOPTIONS_H
#define CS61_FOPTIONS_H
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

typedef struct foptions {
    size_t blocksize;
    double delay;
    const char* filename;
    int flush;
} foptions;

void parse_foptions(int argc, char** argv, foptions* o);

#endif
