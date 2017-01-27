#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
typedef unsigned value_t;
typedef unsigned bool;


struct link {
    value_t value;
    struct link* next;
};

static inline struct link* list_alloc(void) {
    return (struct link*) malloc(sizeof(struct link));
}

static inline void list_free(struct link *link) {
    free(link);
}

void list_add(struct link** list, value_t value) {
    struct link *newlink;
    while (*list && (*list)->value < value)
	list = &(*list)->next;
    newlink = list_alloc();
    newlink->value = value;
    newlink->next = *list;
    *list = newlink;
}

void list_remove(struct link** list, unsigned position) {
    struct link* todelete;
    while (position > 0) {
	list = &(*list)->next;
	--position;
    }
    todelete = *list;
    *list = todelete->next;
    list_free(todelete);
}


int main(int argc, char **argv) {
    unsigned long count = 10000;
    if (argc >= 2)
	count = strtoul(argv[1], 0, 0);

    struct link *list = 0;
    for (unsigned long i = 0; i < count; ++i)
	list_add(&list, random());
    for (unsigned long i = count; i > 0; --i)
	list_remove(&list, random() % i);
}
