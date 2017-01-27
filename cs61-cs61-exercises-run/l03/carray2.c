#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    char *carray = "ABCDEFGHIJKLMNO";

    hexdump(carray, sizeof(carray));
}

