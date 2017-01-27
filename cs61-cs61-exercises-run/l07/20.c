//! -march=i386 -O3
extern int* a;
extern int x;

int f(void) {
    int i, result = 0;

    for (i = 0; i != x; ++i)
        result += a[i];
    return result;
}
