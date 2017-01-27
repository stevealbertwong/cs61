#include <stdio.h>

struct ll {
    int val;
    char *str;
};

char *
func(struct ll *lp, int el) {
    while (lp != NULL)
           if (lp->val == el)
               return (lp->str);

    return (NULL);
}
