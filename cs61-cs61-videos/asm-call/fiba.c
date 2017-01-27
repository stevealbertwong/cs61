/* Recursive fibonacci from day 1. */

unsigned long
fiba (unsigned long n)
{
    if (n < 2)
	return (n);

    return (fiba(n - 1) + fiba(n - 2));
}

