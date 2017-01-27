#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

int main() {
    void* ptr = malloc(2001);
    free((char*) ptr + 100); // pointer arithmetic -> dereference into char so its adding 1 byte in memory address
}
