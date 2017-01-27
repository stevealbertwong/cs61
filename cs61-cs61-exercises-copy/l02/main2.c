#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char ch = 'A';
    char* ptr = &ch;
    fprintf(stderr, "%p\n", ptr);
}

