PROGRAMS = numwave-list \
	numwave-vector \
	numwave-tree

ALLPROGRAMS = $(PROGRAMS) numwave-all \
	numwave-list-prealloc \
	numwave-vector-prealloc \
	numwave-tree-prealloc

CC = $(shell if test -f /opt/local/bin/gcc-mp-4.7; then echo gcc-mp-4.7; else echo gcc; fi)

all: $(PROGRAMS)

OPT = 2
include ../common/rules.mk

%.o: %.c GNUmakefile $(BUILDSTAMP)
	$(call run,$(CC) -O$(OPT) $(CFLAGS) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

$(PROGRAMS): %: %.o
	$(call run,$(CC) -O$(OPT) $(CFLAGS) $(DEPCFLAGS) -o $@ $^,LINK $@)

clean:
	$(call run,rm -f $(ALLPROGRAMS) *.o *.dSYM *.core,CLEAN)
	$(call run,rm -rf $(DEPSDIR))

.PHONY: all clean
