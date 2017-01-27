#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
  (void) argv;
  if( argc > 3 || argc < 2) {
    printf("catafter TIME (FILE)\n");
    return 1;
  }
  
  //TODO
  //HINT: You'll want to use sleep and maybe execvp
}
