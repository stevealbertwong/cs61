#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <assert.h>

int main(int argc, char** argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: ./bidiclient HOST PORT\n");
        fprintf(stderr, "Example: ./bidiclient cs61.seas.harvard.edu 6163\n");
        exit(1);
    }

    // look up network address of server
    struct addrinfo ai_hints, *ai;
    memset(&ai_hints, 0, sizeof(ai_hints));
    ai_hints.ai_family = AF_INET;        // require IPv4
    ai_hints.ai_socktype = SOCK_STREAM;  // require TCP
    ai_hints.ai_flags = 0;
    int r = getaddrinfo(argv[1], argv[2], &ai_hints, &ai);
    if (r != 0) {
        fprintf(stderr, "getaddrinfo(%s, %s): %s\n",
                argv[1], argv[2], gai_strerror(r));
        exit(1);
    }

    // initialize socket
    int fd = socket(ai->ai_family, ai->ai_socktype, 0);
    if (fd < 0) {
        perror("socket");
        exit(1);
    }

    // connect to server
    r = connect(fd, ai->ai_addr, ai->ai_addrlen);
    if (r < 0) {
        perror("connect");
        exit(1);
    }

    // (1) read from standard input, write to socket
    // (2) read from socket, write to standard output
    while (1) {
        char buf[BUFSIZ];
        ssize_t nr = read(STDIN_FILENO, buf, BUFSIZ);
        if (nr != 0 && nr != -1) {
            ssize_t nw = write(fd, buf, nr);
            assert(nw == nr);
        } else if (nr == 0)
            exit(0);
        else if (nr == -1 && errno != EINTR) {
            perror("read");
            exit(1);
        }

        nr = read(fd, buf, BUFSIZ);
        if (nr != 0 && nr != -1) {
            ssize_t nw = write(STDOUT_FILENO, buf, nr);
            assert(nw == nr);
        } else if (nr == 0)
            exit(0);
        else if (nr == -1 && errno != EINTR) {
            perror("read");
            exit(1);
        }
    }
}
