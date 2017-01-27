#include <stdio.h>
#include "hexdump.h"

/*
 * Let's try to figure out if negative numbers
 * are positive numbers with the bits flipped
 */
int
main(int argc, char ** argv)
{
	/* Suppress compiler warnings. */
	(void)argc;
	(void)argv;

	int i;
	int negs[4] = {-1, -2, -3, -4};
	unsigned pos[4] = {1, 2, 3, 4};

	hexdump(pos, sizeof(pos));
	printf("\n");
	for (i = 0; i < 4; i++)
		pos[i] = ~pos[i];
	hexdump(pos, sizeof(pos));
	printf("\n");
	hexdump(negs, sizeof(negs));
}
