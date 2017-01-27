#include <unistd.h>
#include <stdio.h>
#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#define MAX 8192

static void writestr(const char* str) {
    ssize_t n = strlen(str);
    ssize_t w = write(STDOUT_FILENO, str, n);
    assert(n == w);
}

int main(void) {
    char buf[MAX];
    size_t n = 0;
    writestr("cs61echo: Hello\n");
    while (n != MAX) {
        ssize_t r = read(STDIN_FILENO, buf, MAX - n);
        if (r != 0 && r != -1) {
            ssize_t w = write(STDOUT_FILENO, buf, r);
            assert(w == r);
            n += r;
        } else if (r == 0) {
            writestr("cs61echo: Nice talking to you\n");
            exit(0);
        } else if (r == -1 && errno != EINTR) {
            snprintf(buf, MAX, "cs61echo: %s\n", strerror(errno));
            writestr(buf);
            exit(0);
        }
    }
    writestr("cs61echo: I'm bored\n");
    exit(0);
}
