PROGRAMS = bidiclient-threads bidiclient-events
all: $(PROGRAMS)

include ../../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CPPFLAGS) $(CFLAGS) -pthread $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

$(PROGRAMS): %: %.o
	$(call run,$(CC) $(CFLAGS) -pthread -o $@ $^,LINK $@)

clean:
	$(call run,rm -f $(PROGRAMS) *.o *.dSYM *.core,CLEAN)

.PHONY: all clean
