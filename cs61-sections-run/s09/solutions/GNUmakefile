PROGRAMS = catafter_sol runafter_sol tripipe_sol printfirst simplecat
all: $(PROGRAMS)

include ../../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

catafter_sol runafter_sol tripipe_sol printfirst simplecat: %: %.o
	$(call run,$(CC) $(CFLAGS) -o $@ $^,LINK $@)

clean:
	$(call run,rm -rf $(PROGRAMS) *.o *.dSYM *.core,CLEAN)

.PHONY: all clean

