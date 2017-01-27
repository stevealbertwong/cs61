PROGRAMS = bank bank_coarse bank_fine bank_deadlock bank_student \
	client server cs61echo readclient bidiclient bidiclient_student
all: $(PROGRAMS)

include ../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CPPFLAGS) $(CFLAGS) -pthread $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

$(PROGRAMS): %: %.o
	$(call run,$(CC) $(CFLAGS) -pthread -o $@ $^,LINK $@)

clean:
	$(call run,rm -f $(PROGRAMS) *.o *.dSYM *.core,CLEAN)

.PHONY: all clean
