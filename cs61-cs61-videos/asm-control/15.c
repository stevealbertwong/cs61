#include <stdio.h>
extern char c[50];
void
f(void) {
        int i;

        for (i = 0; i < 50; i++)
                printf("%c\n", c[i]);
        printf("\n");
    }
