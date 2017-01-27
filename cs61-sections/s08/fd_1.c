#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
  printf("Normal Program Output 1\n");
  printf("Normal Program Output 2\n");
  printf("Normal Program Output 3\n");
  fprintf(stderr, "Warning!\n");
  printf("Normal Program Output 4\n");
  printf("Normal Program Output 5\n");
}
