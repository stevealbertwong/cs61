MEMBENCH_PROGRAMS = $(patsubst mb-%.c,membench-%,$(wildcard mb-*.c))
ifneq ($(wildcard /usr/lib/libjemalloc* /usr/lib/i386-linux-gnu/libjemalloc*),)
MEMBENCH_PROGRAMS += membench-jemalloc
endif
ifneq ($(wildcard /usr/lib/libtcmalloc_minimal*),)
MEMBENCH_PROGRAMS += membench-tcmalloc
endif

TESTGC_PROGRAMS = $(patsubst gc61%.c,testgc%,$(wildcard gc61*.c))

PROGRAMS = $(MEMBENCH_PROGRAMS) $(TESTGC_PROGRAMS)

all: $(PROGRAMS)

ALLPROGRAMS = $(PROGRAMS) membench-jemalloc membench-tcmalloc

O = 1
include ../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(CC) $(CFLAGS) $(DEPCFLAGS) -O$(O) -o $@ -c $<

%.noopt.o: %.c $(BUILDSTAMP)
	$(CC) $(CFLAGS) $(DEPCFLAGS) -O0 -o $@ -c $<


membench-%: membench.o mb-%.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread

membench-tcmalloc: membench.o mb-malloc.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread $(wordlist 1,1,$(wildcard /usr/lib/libtcmalloc_minimal.*))

membench-jemalloc: membench.o mb-malloc.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread -ljemalloc


testgc: testgc.noopt.o gc61.o
	$(CC) $(CFLAGS) -o $@ $^

.SECONDEXPANSION:
find_testgc_o = $(patsubst %.c,%.noopt.o,$(wordlist 1,1,$(wildcard echo $(1) testgc.c)))
testgc-%: $$(call find_testgc_o,testgc-$$*.c) gc61-%.o
	$(CC) $(CFLAGS) -o $@ $^


clean:
	rm -f $(ALLPROGRAMS) *.o

.PHONY: all clean
