extern int g(int);

int
f(int a, int b)
{
    int s;

    s = 0;
    while (b++ < a) {
        s += g(b);
    }
    return (s);
}
