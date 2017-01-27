#include "iobench.h"

int main(int argc, char** argv) {
    int fd = STDOUT_FILENO;
    if (isatty(fd))
        fd = open("data", O_WRONLY | O_CREAT, 0666);
    if (fd < 0) {
	perror("open");
	exit(1);
    }

    size_t size = 5120000;
    const char* buf = (argc > 1 ? argv[1] : "7");

    const char* pos = buf;
    size_t n = 0;
    while (n < size) {
	ssize_t r = write(fd, pos, 1);
	if (r != 1) {
	    perror("write");
	    exit(1);
	}
        fprintf(stderr, "wrote @%zu %c\n", n, *pos);
	n += r;

        usleep(250000);         // wait for 1/4 sec
        ++pos;
        if (*pos == 0)
            pos = buf;
    }

    close(fd);
}
