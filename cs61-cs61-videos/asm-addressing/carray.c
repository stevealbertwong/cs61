#include <stdlib.h>

char
csum(char *array, int n)
{
	char sum = 0;
	size_t i;

	for (i = 0; i < n; i++)
		sum += array[i];
	return (sum);
}
