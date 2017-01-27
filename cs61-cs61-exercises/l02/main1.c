#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char ch = 'A';
    char* ptr = &ch;
    fprintf(stderr, "%c\n", *ptr);
}

