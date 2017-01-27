#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
  if (argc != 3) {
    printf("Usage: %s program-name text-to-pipe\n", argv[0]);
    exit(1);
  }

  int pipefd[2];
  pipe(pipefd);
  pid_t pid = fork();

  if (pid == -1) {
    perror("Could not fork!\n");
  }
  else if (pid == 0) {
    // child process
    close(pipefd[1]); // close unused write end (for child)

    // make child’s stdin the pipe’s read end
    dup2(pipefd[0], STDIN_FILENO);
    close(pipefd[0]); // close copy
    char *child_argv[] = {argv[1], NULL};
    execvp(argv[1], child_argv); // does not return on success
    perror("Couldn’t execute program!\n");
  }
  else {
    // parent process
    close(pipefd[0]); // close unused read end (for parent)

    // write the given text to the pipe’s write end
    write(pipefd[1], argv[2], strlen(argv[2]));
    close(pipefd[1]);
    waitpid(pid, NULL, 0);
    printf("done\n");
  }
}
