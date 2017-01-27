extern int a, b, x;

int f(void) {
    if (b == x)
        return a;
    else
        return b;
}
