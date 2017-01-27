#include "foptions.h"

// Usage: ./writer [-b BLOCKSIZE] [-d DELAY] [FILE]

int main(int argc, char** argv) {
    foptions opt = { 128, 3, NULL, 0 };
    parse_foptions(argc, argv, &opt);

    int fd;
    if (opt.filename)
        fd = open(opt.filename, O_WRONLY | O_TRUNC | O_CREAT, S_IRUSR | S_IWUSR);
    else
        fd = STDOUT_FILENO;
    if (fd < 0) {
        fprintf(stderr, "%s: %s\n", opt.filename, strerror(errno));
        exit(1);
    }

    // Write `blocksize` bytes at a time, print how much written
    char* buf = (char*) malloc(opt.blocksize);
    memset(buf, '6', opt.blocksize);
    while (1) {
        ssize_t r = write(fd, buf, opt.blocksize);
        if (r == -1) {
            fprintf(stderr, "writer: %s\n", strerror(errno));
            if (errno != EINTR && errno != EWOULDBLOCK)
                break;
        } else if (r == 0) {
            fprintf(stderr, "writer: done\n");
            break;
        } else
            fprintf(stderr, "writer: wrote %zu %s\n", (size_t) r,
                    r == 1 ? "byte" : "bytes");
        if (opt.delay > 0)
            usleep((useconds_t) (opt.delay * 1000000));
    }
}
