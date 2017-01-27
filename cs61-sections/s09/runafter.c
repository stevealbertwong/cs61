#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main( int argc, char **argv ) {
  (void) argv;
  if( argc < 2 ) {
    printf("runafter TIME COMMAND [ARGS...]\n");
    return 1;
  }

  //TODO
  //HINT: You'll want to use sleep and execvp
}
