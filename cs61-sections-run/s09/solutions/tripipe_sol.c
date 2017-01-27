#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <string.h>

int get_next_delimiter( char **argv, char *delim ) {
  int curr_pos = 0;
  while( argv[curr_pos] != NULL && strcmp(argv[curr_pos], delim) != 0) {
	curr_pos++;
  }
  return curr_pos;
}


int main( int argc, char **argv ) {
  (void)argv;
  char *delim = "--";
  int pipefd1[2];
  pipe(pipefd1);


  argv = &argv[1];
  int next_delim = get_next_delimiter(argv, delim);
  pid_t firstpid = fork();
  if (firstpid == -1) {
	perror("Could not fork!\n"); exit(1);
  } else if (firstpid == 0 ) {	//first child process
	close(pipefd1[0]); // close unused read end for first child
	dup2(pipefd1[1], STDOUT_FILENO);
	close(pipefd1[1]); //no need to keep 2 copies of pipe
	argv[next_delim] = NULL;
	execvp(argv[0], argv);
  }
 
  argv = &argv[next_delim + 1];
  int pipefd2[2];
  pipe(pipefd2);
  next_delim = get_next_delimiter(argv, delim);


  pid_t secondpid = fork();
  if (secondpid == -1) {
	perror("Could not fork!\n"); exit(1);
  } else if (secondpid == 0 ) {	//second child process
	close(pipefd1[0]); 
close(pipefd1[1]);
	close(pipefd2[0]); // close unused read end for second child
	dup2(pipefd2[1], STDOUT_FILENO);
	close(pipefd2[1]); //no need to keep 2 copies of pipe
	argv[next_delim] = NULL;
	execvp(argv[0], argv);
  }


  argv = &argv[next_delim + 1];
  next_delim = get_next_delimiter(argv, delim);


  pid_t thirdpid = fork();
  if (thirdpid == -1) {
	perror("Could not fork!\n"); exit(1);
  } else if (thirdpid == 0 ) { //third child process
	close(pipefd1[1]); close(pipefd2[1]); //close unused write ends
	dup2(pipefd1[0], STDIN_FILENO);
	close(pipefd1[0]); //no need to keep 2 copies of pipe
	dup2(pipefd2[0], 3);
	close(pipefd2[0]);
	argv[next_delim] = NULL;
	execvp(argv[0], argv);
  }


  close(pipefd1[0]); close(pipefd1[1]);
  close(pipefd2[0]); close(pipefd2[1]);
  waitpid(thirdpid, NULL, 0);
}
