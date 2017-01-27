extern int g(int);

int
f(int a, int b)
{
    int s;

    s = 0;
    do {
        s += g(b);
    } while (++b < a);
    return (s);
}
