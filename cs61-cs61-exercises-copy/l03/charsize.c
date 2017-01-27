#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    unsigned char ch = 255;
    hexdump(&ch, 1);

    printf("\n");
}

