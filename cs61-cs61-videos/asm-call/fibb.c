
/* Iterative fibonacci from day 1. */

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
