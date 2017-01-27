#define ARRAY_SIZE 10

// Here is a global -- let's see what it looks like!
// Let's assume that the caller allocated space for the array foo.
int *foo;

int
iter(int a)
{
    // Let's iterate over the array and see what that looks like

    int i;
    int sum = 0;
    for (i = 0; i < ARRAY_SIZE; i++)
            sum += foo[i];
    return (sum);
}
