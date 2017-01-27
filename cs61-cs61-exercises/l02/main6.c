#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    char ch = 'A';
    char* ptr = &ch;

    hexdump(ptr, 32);
    ptr[8] = 'B';
    printf("%c\n", ptr[8]);
    hexdump(ptr, 32);
}

