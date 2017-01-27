#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
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
    int sockfd, numbytes;  
    char buf[MAXDATASIZE];
    struct addrinfo hints, *servinfo, *p;
    int rv;
    fd_set readset;
    char s[INET6_ADDRSTRLEN];

    if (argc != 3) {
        fprintf(stderr,"usage: client hostname port\n");
        exit(1);
    }

    char *port = argv[2];
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if ((rv = getaddrinfo(argv[1], port, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }

    for (p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = socket(p->ai_family, p->ai_socktype,
                        p->ai_protocol)) == -1) {
            perror("client: socket");
            continue;
        }
        if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
            close(sockfd);
            perror("client: connect");
            continue;
        }
        break;
    }

    if (p == NULL) {
        fprintf(stderr, "client: failed to connect\n");
        return 2;
    }

    inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
            s, sizeof s);

    freeaddrinfo(servinfo); 

    while (1){
        FD_ZERO(&readset); 
        FD_SET(STDIN_FILENO, &readset);
        FD_SET(sockfd, &readset);

        if (select(sockfd+1, &readset, NULL, NULL, NULL) == -1)
            perror("client: select");

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
    return 0;
}
