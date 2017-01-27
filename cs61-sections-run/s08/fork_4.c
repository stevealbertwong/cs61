#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(void)
{
  printf("a");
  pid_t pid;
  pid = fork();

  if (pid < 0)
  {
    perror("Could not fork\n");
  }

  printf("a");
  
  return 0;
}
