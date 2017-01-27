PROGRAMS = catafter runafter tripipe printfirst simplecat dup2_2
all: $(PROGRAMS)

include ../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

catafter runafter tripipe printfirst simplecat dup2_2: %: %.o
	$(call run,$(CC) $(CFLAGS) -o $@ $^,LINK $@)

clean:
	$(call run,rm -rf $(PROGRAMS) *.o *.dSYM *.core,CLEAN)

.PHONY: all clean

