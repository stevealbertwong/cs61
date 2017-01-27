#include "foptions.h"
size_t my_fread(void* buf, size_t sz, size_t nmemb, FILE* f);

// Usage: ./freader [-b BLOCKSIZE] [-d DELAY] [FILE]

int main(int argc, char** argv) {
    foptions opt = { 100, 2, NULL, 0 };
    parse_foptions(argc, argv, &opt);

    FILE* f;
    if (opt.filename)
        f = fopen(opt.filename, "r");
    else
        f = stdin;
    if (!f) {
        fprintf(stderr, "%s: %s\n", opt.filename, strerror(errno));
        exit(1);
    }

    // Read `blocksize` bytes at a time, print how much read
    char* buf = (char*) malloc(opt.blocksize);
    while (1) {
        size_t r = fread(buf, 1, opt.blocksize, f);
        if (r == 0 && ferror(f)) {
            fprintf(stderr, "freader: error\n");
            break;
        } else if (r == 0) {
            fprintf(stderr, "freader: done\n");
            break;
        } else
            fprintf(stderr, "freader: read %zu %s\n", (size_t) r,
                    r == 1 ? "byte" : "bytes");
        if (opt.delay > 0)
            usleep((useconds_t) (opt.delay * 1000000));
    }
}


// An *incorrect* implementation of fread() in terms of read().
// How would you fix it?
size_t my_fread(void* buf, size_t sz, size_t nmemb, FILE* f) {
    return read(fileno(f), buf, sz * nmemb);
}
