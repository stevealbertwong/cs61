#include "iobench.h"

int main() {
    FILE* f = stdin;
    if (isatty(fileno(f)))
        f = fopen("data", "r");
    if (!f) {
	perror("fopen");
	exit(1);
    }

    size_t size = filesize(fileno(f));

    size_t n = 0;
    while (n < size) {
	int ch = fgetc(f);
	if (ch == EOF && ferror(f)) {
	    perror("fgetc");
	    exit(1);
	} else if (ch == EOF)
            break;
        fprintf(stderr, "read @%zu %c\n", n, ch);
	n += 1;

        usleep(500000);		// wait for 1/2 sec
    }

    fclose(f);
}
