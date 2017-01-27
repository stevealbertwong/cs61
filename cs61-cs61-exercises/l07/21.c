#include <stdlib.h>
struct foo {
    int i;
    char c;
    long long l;
};

struct foo *
f(void) {
    int i;
    struct foo *fp;

    fp = malloc(10 * sizeof(struct foo));
    for (i = 0; i < 10; i++) {
        fp[i].i = i;
        fp[i].c = (char)i;
        fp[i].l = (long long)i;
    }            
    return (fp);
}
