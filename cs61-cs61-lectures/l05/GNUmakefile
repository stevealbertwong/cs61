MEMBENCH_PROGRAMS = $(patsubst mb-%.c,membench-%,$(wildcard mb-*.c))
ifneq ($(wildcard /usr/lib/libjemalloc* /usr/lib/i386-linux-gnu/libjemalloc*),)
MEMBENCH_PROGRAMS += membench-jemalloc
endif
ifneq ($(wildcard /usr/lib/libtcmalloc_minimal*),)
MEMBENCH_PROGRAMS += membench-tcmalloc
endif

PROGRAMS = fib testalignment testalignment-gcd \
	$(MEMBENCH_PROGRAMS)

all: $(PROGRAMS)

ALLPROGRAMS = $(PROGRAMS) membench-jemalloc membench-tcmalloc

O = 1
include ../common/rules.mk

UNSAFE_CFLAGS := $(CFLAGS) -U_FORTIFY_SOURCE -fno-stack-protector
ifeq ($(CLANG),1)
#CFLAGS += -fsanitize=address
endif

%.o: %.c $(BUILDSTAMP)
	$(CC) $(CFLAGS) $(DEPCFLAGS) -O$(O) -o $@ -c $<

%.noopt.o: %.c $(BUILDSTAMP)
	$(CC) $(CFLAGS) $(DEPCFLAGS) -O0 -o $@ -c $<

%.unsafe.o: %.c $(BUILDSTAMP)
	$(CC) $(UNSAFE_CFLAGS) $(DEPCFLAGS) -O$(O) -o $@ -c $<


fib: fib.o
	$(CC) $(CFLAGS) -O$(O) -o $@ $^

testalignment: testalignment.o
	$(CC) $(CFLAGS) -O$(O) -o $@ $^

testalignment-gcd: testalignment-gcd.o
	$(CC) $(CFLAGS) -O$(O) -o $@ $^


membench-%: membench.o mb-%.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread

membench-tcmalloc: membench.o mb-malloc.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread $(wordlist 1,1,$(wildcard /usr/lib/libtcmalloc_minimal.*))

membench-jemalloc: membench.o mb-malloc.o
	$(CC) $(CFLAGS) -o $@ $^ -lpthread -ljemalloc


clean:
	rm -f $(ALLPROGRAMS) *.o

.PHONY: all clean
