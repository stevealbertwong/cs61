#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    int i = 0x89ABCDEF;
    hexdump(&i, sizeof(i));
}

