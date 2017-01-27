#include "foptions.h"

// Usage: ./fwriter [-b BLOCKSIZE] [-d DELAY] [-n] [FILE]

int main(int argc, char** argv) {
    foptions opt = { 128, 3, NULL, 1 };
    parse_foptions(argc, argv, &opt);

    FILE* f;
    if (opt.filename)
        f = fopen(opt.filename, "w");
    else
        f = stdout;
    if (!f) {
        fprintf(stderr, "%s: %s\n", opt.filename, strerror(errno));
        exit(1);
    }

    // Write `blocksize` bytes at a time, print how much written
    char* buf = (char*) malloc(opt.blocksize);
    memset(buf, '6', opt.blocksize);
    while (1) {
        size_t r = fwrite(buf, 1, opt.blocksize, f);
        if (r == 0 && ferror(f)) {
            fprintf(stderr, "fwriter: error\n");
            break;
        } else if (r == 0) {
            fprintf(stderr, "fwriter: done\n");
            break;
        } else
            fprintf(stderr, "fwriter: wrote %zu %s\n", (size_t) r,
                    r == 1 ? "byte" : "bytes");
        if (opt.flush)
            fflush(f);
        if (opt.delay > 0)
            usleep((useconds_t) (opt.delay * 1000000));
    }
}
