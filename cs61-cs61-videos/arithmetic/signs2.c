#include <stdio.h>
#include "hexdump.h"

int
main(int argc, char ** argv)
{
	/* Suppress compiler warnings. */
	(void)argc;
	(void)argv;

	int negs[4] = {-1, -2, -3, -4};

	hexdump(negs, sizeof(negs));
}
