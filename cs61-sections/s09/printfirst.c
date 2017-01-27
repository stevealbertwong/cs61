#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/time.h>
#include <assert.h>

void read_all(int fd);

// We've done this for you! You don't have to understand the 
// select statement, but it is a useful thing to know.
int main() {
  fd_set readfds;
 
  FD_ZERO(&readfds);
  FD_SET(STDIN_FILENO, &readfds);
  FD_SET(3, &readfds);
 
  select(3 + 1, &readfds, NULL, NULL, NULL);
  if( FD_ISSET(STDIN_FILENO, &readfds)) {
	close(3);
	read_all(STDIN_FILENO);
  } else {
	close(STDIN_FILENO);
	read_all(3);
  }
}

void read_all(int fd) {
  char ch;
  while( read( fd, &ch, 1 ) > 0 )
	printf("%c", ch);
}
