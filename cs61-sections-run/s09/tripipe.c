#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <string.h>

//returns the position of the next delimiter in the argv list
int get_next_delimiter( char **argv, char *delim);

int main( int argc, char **argv ) {
  char *delim = "--";
  if( argc < 6 ) {
    printf("Usage: %s a b c -- d e f g -- h i j k l\n", argv[0] );
    exit(1);
  }

  //TODO: SETUP PIPE 1

  argv = &argv[1]; //ignore "tripipe" argument
  int next_delim = get_next_delimiter(argv, delim);
  
  pid_t firstpid = fork();
  if (firstpid == -1) {
    perror("Could not fork!\n");
    exit(1);
  } else if (firstpid == 0 ) { //first child process
    //TODO: Setup process to write to the first pipe
  }
  
  argv = &argv[next_delim + 1];
  next_delim = get_next_delimiter(argv, delim);

  //TODO: SETUP PIPE 2

  pid_t secondpid = fork();
  if (secondpid == -1) {
    perror("Could not fork!\n");
    exit(1);
  } else if (secondpid == 0 ) { //second child process
    //TODO: Setup process to write to the second pipe
  }

  argv = &argv[next_delim + 1];
  next_delim = get_next_delimiter(argv, delim);

  pid_t thirdpid = fork();
  if (thirdpid == -1) {
    perror("Could not fork!\n");
    exit(1);
  } else if (thirdpid == 0 ) { //third child process
    //TODO: Setup process to read from both pipes
  }

  //TODO: Close all unused pipes and wait for child processes to finish
}

int get_next_delimiter( char **argv, char *delim ) {
  int curr_pos = 0;
  while( argv[curr_pos] != NULL && strcmp(argv[curr_pos], delim) != 0) {
    curr_pos++;
  }
  return curr_pos;
}


