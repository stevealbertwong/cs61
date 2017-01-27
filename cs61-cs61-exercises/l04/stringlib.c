/*
 * Library to provide strings with explicit sizes.
 * Your goal is to implement a (somewhat) safer string that uses explicit
 * sizes rather than Nul termination to indicate how long a string is.
 *
 * You should return to the caller a pointer to the memory location where
 * the characters comprising the string start, but you should prepend enough
 * metadata to that storage space to store the size of the string.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stringlib.h"

/* Create a safe string from a (Null-terminated) C-string. */
char *
string_new(char *cstr)
{
    /* Your code goes here. */
    return (NULL);
}

/* Make a copy of a safe string. */
char *
string_dup(char *sstr) {
    /* Your code goes here. */
    return (NULL);
}

/* Compare two safe strings. */
int
string_cmp(char *sstr1, char * sstr2) {
    /* Your code goes here. */
    return (0);
}

/* Concatenate two safe strings. */
char *
string_cat(char *sstr1, char *sstr2) {
    /* Your code goes here. */
    return (NULL);
}

void
string_free(char *sstr)
{
    return;
}

/* Print out safe string */
void
string_print(char *sstr)
{
    return;
}

