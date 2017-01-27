#include "iobench.h"

int main(int argc, char** argv) {
    FILE* f = stdout;
    if (isatty(fileno(f)))
        f = fopen("data", "r+");
    if (!f) {
	perror("fopen");
	exit(1);
    }

    size_t size = 5120000;
    const char* buf = (argc > 1 ? argv[1] : "7");

    const char* pos = buf;
    size_t n = 0;
    while (n < size) {
	size_t r = fwrite(pos, 1, 1, f);
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

    fclose(f);
}
