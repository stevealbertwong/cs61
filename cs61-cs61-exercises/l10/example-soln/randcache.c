#define PRINT_FREQUENCY 100

#include <sys/stat.h>
#include <errno.h>
#include <getopt.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "iobench.h"
#include "cache.h"

// Generate a random number in the range [Lo,Hi]
#define RAND_RANGE(Lo, Hi) \
    Lo + ((Hi - Lo + 1) * (random() / (double)RAND_MAX))

// Generate a random number from a pareto distribution with parameter P
// Between 0 and MAX
double p = 75.0;
#define PPLUS1 (1 + p)
#define E (1 / PPLUS1)

size_t
skewed_random(size_t max)
{
    double q = pow(max, PPLUS1);

    return (size_t)(pow(q * drand48(), E));
}

int
usage()
{
    fprintf(stderr, "usage: ./randread [-b blocksize] [-f file] %s\n",
        "[-o ops] [-p skew parameter]");
    return (-1);
}

void
readblock(int fd, void *buf, size_t blocksize, size_t blocknum)
{
    off_t off;

    off = blocksize * blocknum;

    if (lseek(fd, off, SEEK_SET) != off) {
        fprintf(stderr, "Lseek: %s\n", (strerror(errno)));
        exit(1);
    }

    if (read(fd, buf, blocksize) != blocksize) {
        fprintf(stderr, "Read: %s\n", (strerror(errno)));
        exit(1);
    }
}

int
main(int argc, char *argv[])
{
    extern int optind;
    char* buf;
    char ch;
    char *file;
    double start;
    int fd, i;
    long ops;
    size_t blocknum, blocksize, max_block, totbytes;
    struct stat statbuf;


    blocksize = 512;
    file = "data";
    ops = 1000;

    /* Command line processing. */
    while ((ch = getopt(argc, argv, "b:f:o:p:")) != EOF)
	switch (ch) {
        case 'b':
            blocksize = (size_t)strtol(optarg, NULL, 10);
            break;
        case 'f':
            file = optarg;
            break;
        case 'o':
            ops =strtol(optarg, NULL, 10);
            break;
        case 'p':
            p = strtod(optarg, NULL);
            break;
	    default:
		    return (usage());
	}

    argc -= optind;
    argv += optind;

    if (argc != 0)
	    return (usage());

    
    // fd = open("data", O_RDONLY);
    fd = cache_file_open("data", O_RDONLY);
    if (fd < 0) {
        fprintf(stderr, "Open: %s\n", (strerror(errno)));
        exit(1);
    }
    if (fstat(fd, &statbuf) != 0) {
        fprintf(stderr, "Fstat: %s\n", (strerror(errno)));
        exit(1);
    }
    max_block = (statbuf.st_size / blocksize) - 1;

    if ((buf = malloc(blocksize)) == NULL) {
        fprintf(stderr, "Malloc: %s\n", (strerror(errno)));
        exit(1);
    }
    totbytes = 0;
    start = tstamp();
    for (i = 0; i < ops; i++) {
        blocknum = (off_t)skewed_random(max_block);
        totbytes += blocksize;
        // readblock(fd, buf, blocksize, blocknum);
        // printf("%zu\n", blocknum);
        cache_read_block(fd, buf, blocksize, blocknum);

        if (i % PRINT_FREQUENCY == 0)
            report(totbytes, tstamp() - start);
    }

    close(fd);
    report(totbytes, tstamp() - start);
    fprintf(stderr, "\n");
    cache_stats();
}
