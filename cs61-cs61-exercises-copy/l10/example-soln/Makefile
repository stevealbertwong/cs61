IOBENCH_PROGRAMS = r01-byte randcache

PROGRAMS = $(IOBENCH_PROGRAMS)

all: $(PROGRAMS)

ALLPROGRAMS = $(PROGRAMS)

INCLUDES = -I. -I..
CFLAGS = -g -O1 -Wall $(INCLUDES)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

$(IOBENCH_PROGRAMS): %: %.o
	$(CC) $(CFLAGS) -o $@ $<

randcache: randcache.o cache.o
	$(CC) $(CFLAGS) -o $@ $< cache.o -lm

r01-cache: r01-cache.o cache.o
	$(CC) $(CFLAGS) -o $@ $< cache.o

clean:
		/bin/rm -rf $(PROGRAMS) *.o a.out core

.PHONY: all clean plot replot
