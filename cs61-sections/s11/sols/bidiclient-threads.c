#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <assert.h>
#include <pthread.h>

typedef struct thread_args {
    int readfd;
    int writefd;
    int shutdown;
} thread_args;

static void* threadfunc(void* args) {
    char buf[BUFSIZ];
    thread_args* ta = (thread_args*) args;
    while (1) {
        ssize_t nr = read(ta->readfd, buf, BUFSIZ);
        if (nr != 0 && nr != -1) {
            ssize_t nw = write(ta->writefd, buf, nr);
            assert(nw == nr);
        } else if (nr == 0) {
            if (ta->shutdown)
                shutdown(ta->writefd, SHUT_WR);
            return NULL; // exit the thread, but not the program
        } else if (nr == -1 && errno != EINTR) {
            perror("read");
            exit(1);
        }
    }
}

int main(int argc, char** argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: ./bidiclient3 HOST PORT\n");
        fprintf(stderr, "Example: ./bidiclient3 cs61.seas.harvard.edu 6163\n");
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
    // AND IN PARALLEL
    // (2) read from socket, write to standard output
    // using threads
    thread_args ta1 = { STDIN_FILENO, fd, 1 };
    pthread_t threadid1;
    r = pthread_create(&threadid1, NULL, &threadfunc, &ta1);

    thread_args ta2 = { fd, STDOUT_FILENO, 0 };
    pthread_t threadid2;
    r = pthread_create(&threadid2, NULL, &threadfunc, &ta2);

    // wait until the threads complete
    pthread_join(threadid1, NULL);
    pthread_join(threadid2, NULL);
    exit(0);
}
