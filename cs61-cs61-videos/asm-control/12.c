extern unsigned a;

int f(void) {
    if (a)
        return 0;
    else
        return 1;
}
