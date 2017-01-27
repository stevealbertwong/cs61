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
    printf("Usage: %s first-prog second-prog\n", argv[0]);
    exit(1);
  }

  // This will perform: first-prog | second-prog
  int pipefd[2];
  pipe(pipefd);

  pid_t firstpid = fork();
  if (firstpid == -1) {
    perror("Could not fork!\n");
    exit(1);
  } else if (firstpid == 0) {
    // first child process
    close(pipefd[0]); // close unused read end for first child

    // make first child's stdout the pipe's write end
    dup2(pipefd[1], STDOUT_FILENO);
    close(pipefd[1]); // no need keep 2 copies of pipe
    char *child_argv[] = {argv[1], NULL};
    execvp(argv[1], child_argv); // does not return on success
    perror("Couldn't execute program!\n");
    exit(1);
  }

  pid_t secondpid = fork();
  if (secondpid == -1) {
    perror("Could not fork!\n");
    exit(1);
  } else if (secondpid == 0) {
    // second child process
    close(pipefd[1]); // close unused write end of second child

    // make second child's stdin the pipe's read end
    dup2(pipefd[0], STDIN_FILENO);
    close(pipefd[0]); // no need keep 2 copies of pipe
    char *child_argv[] = {argv[2], NULL};
    execvp(argv[2], child_argv); // does not return on success
    perror("Couldn't execute program!\n");
    exit(1);
  }

  // back in main parent process
  close(pipefd[0]); // parent does not read or write to pipe
  close(pipefd[1]);
  waitpid(firstpid, NULL, 0);
  waitpid(secondpid, NULL, 0);
  printf("done\n");
}
