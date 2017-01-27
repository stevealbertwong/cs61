#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
typedef unsigned value_t;
typedef unsigned bool;


struct vector {
    unsigned size;
    unsigned capacity;
    value_t* data;
};

static inline void vector_init(struct vector* v) {
    v->size = v->capacity = 0;
    v->data = 0;
}

static inline void vector_grow(struct vector* v) {
    unsigned new_capacity = (v->capacity ? v->capacity * 2 : 16);
    value_t* new_data = (value_t*) malloc(sizeof(value_t) * new_capacity);
    memcpy(new_data, v->data, sizeof(value_t) * v->size);
    free(v->data);
    v->data = new_data;
    v->capacity = new_capacity;
}

void vector_add(struct vector* v, value_t value) {
    unsigned position = 0;
    while (position != v->size && v->data[position] < value)
	++position;
    if (v->size == v->capacity)
	vector_grow(v);
    memmove(&v->data[position + 1], &v->data[position],
	    sizeof(value_t) * (v->size - position));
    v->data[position] = value;
    ++v->size;
}

void vector_remove(struct vector* v, unsigned position) {
    unsigned cur_position = 0;
    while (cur_position != position)
	++cur_position;
    memmove(&v->data[cur_position], &v->data[cur_position + 1],
	    sizeof(value_t) * (v->size - cur_position - 1));
    --v->size;
}


int main(int argc, char** argv) {
    unsigned long count = 10000;
    if (argc >= 2)
	count = strtoul(argv[1], 0, 0);

    struct vector v;
    vector_init(&v);
    for (unsigned long i = 0; i < count; ++i)
	vector_add(&v, random());
    for (unsigned long i = count; i > 0; --i)
	vector_remove(&v, random() % i);
}
