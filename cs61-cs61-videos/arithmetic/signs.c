#include <stdio.h>
#include "hexdump.h"

int
main(int argc, char ** argv)
{
	/* Suppress compiler warnings. */
	(void)argc;
	(void)argv;

	int i = 1;
	unsigned u = 1;
	int j = -1;

	printf("int 1 = %d unsigned 1 = %u int -1 = %d\n", i, u, j);
	hexdump(&i, sizeof(i));
	printf("\n");
	hexdump(&u, sizeof(u));
	printf("\n");
	hexdump(&j, sizeof(j));
}
