#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    char carray[10] = {50, 51, 52, 53, 54, 55, 56, 57, 58, 59};
    char c1, c2;
    char *c1p, *c2p;

    int iarray[10] = {50, 51, 52, 53, 54, 55, 56, 57, 58, 59};
    int i1, i2;
    int *i1p, *i2p;

    double darray[10] = {50, 51, 52, 53, 54, 55, 56, 57, 58, 59};
    double d1, d2;
    double *d1p, *d2p;

    hexdump(carray, sizeof(char));
    hexdump(&carray[5], sizeof(carray[5]));
    printf("\n");
    hexdump(iarray, sizeof(int));
    hexdump(&iarray[5], sizeof(iarray[5]));
    printf("\n");
    hexdump(darray, sizeof(double));
    hexdump(&darray[5], sizeof(darray[5]));
    printf("\n");
}

