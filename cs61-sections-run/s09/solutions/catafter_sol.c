#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
    
    if(argc < 2){
        printf("USAGE: ./catafter_sol TIME (optional: FILE)\n");
        abort();
    }
    
    sleep(atoi( argv[1] ) );
    if(argc == 3 ) {
        int fd_to_read = open(argv[2], O_RDONLY);
        dup2(fd_to_read, STDIN_FILENO);
        close(fd_to_read);
    }

    char* prog[] = {"cat", NULL};
    execvp(prog[0], prog);
}
