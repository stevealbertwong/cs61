#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main( int argc, char **argv ) {
    
    if(argc != 2){
        printf("USAGE: ./simplecat FILE\n");
        abort();
    }
    (void)argc;
    char* prog[] = {"cat", argv[1], NULL};
    execvp(prog[0], &prog[0]);
}


