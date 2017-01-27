#include <errno.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "limit.h"

/*
 * Compute either iterative or recursive fibonacci.  The fibonacci series
 * is defined either as:
 * F(0) = 0, F(1) = 1, F(n : n > 1) = F(n-1) + F(n-2)
 * or
 * F(1) = 1, F(2) = 1, F(n : n > 2) = F(n-1) + F(n-2)
 * We will use the first definition here.
 */

int
usage()
{
    fprintf(stderr, "usage: ./fib [-ab] n\n");
    return (-1);
}

unsigned long
fiba (unsigned long n)
{
    if (n < 2)
	return (n);

    return (fiba(n - 1) + fiba(n - 2));
}

unsigned long
fibb (unsigned long n)
{
    unsigned long i, last, sum, tmp;
    if (n < 2)
	return (n);

    last = 0;
    sum = 1;
    for (i = 2; i <= n; i++) {
	tmp = sum;
	sum += last;
	last = tmp;
    }

    return (sum);
}

int
main(int argc, char *argv[])
{
    extern int optind;
    char ch;
    int do_fiba = 1;
    unsigned long f, n;

    limit_stack_size(128 * 1024);	/* 128 KB stack. */

    /* Command line processing. */
    while ((ch = getopt(argc, argv, "ab")) != EOF)
	switch (ch) {
	    case 'a':
		do_fiba = 1;
		break;
	    case 'b':
		do_fiba = 0;
		break;
	    case '?':
	    default:
		return (usage());
	}

    argc -= optind;
    argv += optind;

    if (argc != 1)
	return (usage());

    n = strtoul(argv[0], NULL, 10);
    if (n == 0 && errno == EINVAL)
	return (usage());
    
    /* Now call one of the fib routines. */
    f = do_fiba ? fiba(n) : fibb(n);
    printf("fib(%lu) = %lu\n", n, f);

    return (0);
}

