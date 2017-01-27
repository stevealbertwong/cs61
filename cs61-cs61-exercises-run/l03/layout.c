#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

int main(void) {
    char carray[12] = 
        { 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111 };
    int *ip;
    struct s {
        int a;
        char b;
    } *sp;
    union u {
        int u;
        char c;
        double d;
    } *up;

    /*
     * We are placing an integer in the midst of the character array so
     * that you can see how the integer overlays with the bytes in the
     * character array. We then ask you to modify the program to place
     * the struct and union into the character array similarly so you
     * can see how their fields are allocated as well. You will want to
     * assign sp (up) to one of the array addresses as we do below, and
     * then fill in the struct (union) with distinct values that you
     * can recognize in the output.
     */
    ip = (int *)&carray[4];
    *ip = 0xabcdef98;

    printf("sizeof(carray) = %zu\n", sizeof(carray));
    hexdump(carray, sizeof(carray));
}

