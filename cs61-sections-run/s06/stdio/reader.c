#include "foptions.h"

// Usage: ./reader [-b BLOCKSIZE] [-d DELAY] [FILE]

int main(int argc, char** argv) {
    foptions opt = { 100, 2, NULL, 0 };
    parse_foptions(argc, argv, &opt);

    int fd;
    if (opt.filename)
        fd = open(opt.filename, O_RDONLY);
    else
        fd = STDIN_FILENO;
    if (fd < 0) {
        fprintf(stderr, "%s: %s\n", opt.filename, strerror(errno));
        exit(1);
    }

    // Read `blocksize` bytes at a time, print how much read
    char* buf = (char*) malloc(opt.blocksize);
    while (1) {
        ssize_t r = read(fd, buf, opt.blocksize);
        if (r == -1) {
            fprintf(stderr, "reader: %s\n", strerror(errno));
            if (errno != EINTR && errno != EWOULDBLOCK)
                break;
        } else if (r == 0) {
            fprintf(stderr, "reader: done\n");
            break;
        } else
            fprintf(stderr, "reader: read %zu %s\n", (size_t) r,
                    r == 1 ? "byte" : "bytes");
        if (opt.delay > 0)
            usleep((useconds_t) (opt.delay * 1000000));
    }
}
