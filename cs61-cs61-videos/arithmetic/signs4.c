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

	/* Let's use printf to do the conversions. */
	printf("%d %u\n", 0xffffffff, 0xffffffff);
	printf("%d %u\n", -1234, -1234);
}
