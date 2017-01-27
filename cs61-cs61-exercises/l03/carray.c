#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    unsigned char carray[16];

    carray[0] = 'A';
    carray[1] = 'B';
    carray[2] = 'C';
    carray[3] = 'D';
    carray[4] = 'E';
    carray[5] = 'F';
    carray[6] = 'G';
    carray[7] = 'H';
    carray[8] = 'I';
    carray[9] = 'J';
    carray[10] = 'K';
    carray[11] = 'L';
    carray[12] = 'M';
    carray[13] = 'N';
    carray[14] = 'O';
    carray[15] = 0;
    hexdump(carray, sizeof(carray));
}

