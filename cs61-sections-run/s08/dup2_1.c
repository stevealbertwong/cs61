#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

int main(int argc, char **argv) {

  if (argc != 4) {
    printf("Usage: %s program-name infile outfile\n", argv[0]);
    exit(1);
  }

  pid_t pid = fork();

  if (pid == -1) {
    perror("Could not fork!\n");
  }
  else if (pid == 0) {
    // child process
    int fdin = open(argv[2], O_RDONLY, 0666);
    int fdout = open(argv[3], O_WRONLY|O_CREAT, 0666);
    dup2(fdin, STDIN_FILENO);
    dup2(fdout, STDOUT_FILENO);
    // close now unused fds
    close(fdin);
    close(fdout);
    char *child_argv[] = {argv[1], NULL};
    execvp(argv[1], child_argv); // does not return on success
    perror("Couldn’t execute program!\n");
  }
  else {
    // parent process
    waitpid(pid, NULL, 0);
    printf("done\n");
  }
}
