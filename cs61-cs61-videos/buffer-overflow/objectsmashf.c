#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct line_object {
    char buffer[100];
    void (*read_method)(struct line_object* lo);
    void (*print_method)(struct line_object* lo);
} line_object;

void read_line(char* buffer) {
    gets(buffer);
}

void line_read_method(line_object* lo) {
    read_line(lo->buffer);
}

void line_print_method(line_object* lo) {
    if (strlen(lo->buffer))
        printf("Read %d character(s)\n", strlen(lo->buffer));
    else
        printf("Read nothing\n");
}

int main() {
    line_object* lo = (line_object*) malloc(sizeof(line_object));
    lo->read_method = &line_read_method;
    lo->print_method = &line_print_method;

    lo->read_method(lo);
    lo->print_method(lo);
}
