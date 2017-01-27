#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    unsigned int iarray[16];

    iarray[0] = 'A';
    iarray[1] = 'B';
    iarray[2] = 'C';
    iarray[3] = 'D';
    iarray[4] = 'E';
    iarray[5] = 'F';
    iarray[6] = 'G';
    iarray[7] = 'H';
    iarray[8] = 'I';
    iarray[9] = 'J';
    iarray[10] = 'K';
    iarray[11] = 'L';
    iarray[12] = 'M';
    iarray[13] = 'N';
    iarray[14] = 'O';
    iarray[15] = 0;
    hexdump(iarray, sizeof(iarray));
}

