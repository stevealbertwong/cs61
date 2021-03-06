#include <stdio.h>
#include <stdlib.h>
#include "hexdump.h"

char global_ch = 'B';
const char const_global_ch = 'C';

int main(int argc, char *argv[]) {
    char ch = 'A';
    char* heap_ch = (char*) malloc(1);
    *heap_ch = 'D';

    hexdump(&ch, 1);
    hexdump(&global_ch, 1);
    hexdump(&const_global_ch, 1);
    hexdump(heap_ch, 1);
}

