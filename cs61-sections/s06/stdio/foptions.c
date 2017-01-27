#include "foptions.h"

void parse_foptions(int argc, char** argv, foptions* o) {
    const char* program_name = argv[0];

    while (argc > 1 && argv[1][0] == '-') {
        if (strcmp(argv[1], "-b") == 0 && argc > 2) {
            o->blocksize = strtoul(argv[2], NULL, 0);
            argc -= 2, argv += 2;
        } else if (strcmp(argv[1], "-d") == 0 && argc > 2) {
            o->delay = strtod(argv[2], NULL);
            argc -= 2, argv += 2;
        } else if (strcmp(argv[1], "-f") == 0) {
            o->flush = 1;
            argc -= 1, argv += 1;
        } else if (strcmp(argv[1], "-n") == 0) {
            o->flush = 0;
            argc -= 1, argv += 1;
        } else if (strcmp(argv[1], "-") == 0 && argc == 2) {
            o->filename = NULL;
            return;
        } else {
            fprintf(stderr, "Usage: %s [-b BLOCKSIZE] [-d DELAY] [-n] [FILE]\n",
                    program_name);
            exit(1);
        }
    }

    if (argc > 1)
        o->filename = argv[1];
}
