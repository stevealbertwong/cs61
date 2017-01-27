PROGRAMS = stacksmash stacksmash.unsafe stacksmashf stacksmashf.unsafe 

all: $(PROGRAMS)

ALLPROGRAMS = $(PROGRAMS)
PREFER_GCC ?= 1

include rules.mk

UNSAFE_CFLAGS := $(CFLAGS) -U_FORTIFY_SOURCE -fno-stack-protector


%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) -O$(O) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

%.noopt.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) -O0 $(DEPCFLAGS) -o $@ -c,COMPILE -O0,$<)

%.unsafe.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(UNSAFE_CFLAGS) -O$(O) $(DEPCFLAGS) -o $@ -c,UNSAFE COMPILE,$<)

%.prof.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) -pg -O$(O) $(DEPCFLAGS) -o $@ -c,COMPILE -pg,$<)


stacksmash: stacksmash.o 
	$(call run,$(CC) $(CFLAGS) -O$(O) -o $@ $^,LINK $@)

stacksmash.unsafe: stacksmash.unsafe.o
	$(call run,$(CC) $(UNSAFE_CFLAGS) -O$(O) -o $@ $^,LINK UNSAFE $@)

stacksmashf: stacksmashf.o
	$(call run,$(CC) $(CFLAGS) -O$(O) -o $@ $^,LINK $@)

stacksmashf.unsafe: stacksmashf.unsafe.o
	$(call run,$(CC) $(UNSAFE_CFLAGS) -O$(O) -o $@ $^,LINK UNSAFE $@)

clean:
	$(call run,rm -f $(ALLPROGRAMS) *.o *.dSYM *.core,CLEAN)
	$(call run,rm -rf $(DEPSDIR))

.PHONY: all clean 

