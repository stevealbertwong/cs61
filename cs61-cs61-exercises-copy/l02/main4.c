#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char ch = 'A';
    char* ptr = &ch;
    ptr[8] = 'B';
    printf("%c\n", ptr[8]);
}

