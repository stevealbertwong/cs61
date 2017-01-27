#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    unsigned char ch = 0x47;
    unsigned char ch2 = 'G';
    hexdump(&ch, 1);

    printf("\n");

    hexdump(&ch2, 1);
}

