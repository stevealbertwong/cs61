#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

#define MAXDATASIZE 1024

void *get_in_addr(struct sockaddr *sa)
{
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int main(int argc, char **argv)
{
    int sockfd, fd;
    struct addrinfo hints, *servinfo, *p;
    struct sockaddr_storage their_addr;
    socklen_t sin_size;
    int yes=1;
    char s[INET6_ADDRSTRLEN];
    char buf[MAXDATASIZE];
    int numbytes;
    fd_set readset;
    int rv;

    if (argc != 2) {
        fprintf(stderr,"usage: server port\n");
        exit(1);
    }

    char *port = argv[1];
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE;

    if ((rv = getaddrinfo(NULL, port, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }

    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((fd = socket(p->ai_family, p->ai_socktype,
                        p->ai_protocol)) == -1) {
            perror("server: socket");
            continue;
        }

        if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes,
                    sizeof(int)) == -1) {
            perror("setsockopt");
            exit(1);
        }

        if (bind(fd, p->ai_addr, p->ai_addrlen) == -1) {
            close(fd);
            perror("server: bind");
            continue;
        }

        break;
    }

    if (p == NULL)  {
        fprintf(stderr, "server: failed to bind\n");
        return 2;
    }

    freeaddrinfo(servinfo);

    if (listen(fd, 1) == -1) {
        perror("listen");
        exit(1);
    }

    sin_size = sizeof their_addr;
    sockfd = accept(fd, (struct sockaddr *)&their_addr, &sin_size);
    if (fd == -1) {
        perror("accept");
    }

    inet_ntop(their_addr.ss_family,
            get_in_addr((struct sockaddr *)&their_addr),
            s, sizeof s);

    while(1){

        FD_ZERO(&readset);
        FD_SET(STDIN_FILENO, &readset);
        FD_SET(sockfd, &readset);

        if (select(sockfd+1, &readset, NULL, NULL, NULL) == -1)
            perror("server: select");

        if (FD_ISSET(STDIN_FILENO, &readset)){
            numbytes = read(STDIN_FILENO, buf, sizeof(buf));
            if (numbytes == 0)
                break;
            if (send(sockfd, buf, numbytes, 0) == -1)
                perror("send");
        }
        if (FD_ISSET(sockfd, &readset)){
            numbytes = recv(sockfd, buf, MAXDATASIZE-1, 0);
            if (numbytes == -1){
                perror("recv");
            } else if (numbytes == 0) {
                break;
            }
            write(STDOUT_FILENO, buf, numbytes);
        }
    }
    close(sockfd);
    close(fd);
    return 0;
}
