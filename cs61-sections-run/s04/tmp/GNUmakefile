# Default optimization level
O ?= -O0

PROGRAMS = call

all: $(PROGRAMS)

include ../../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPCFLAGS) $(O) -o $@ -c $<

%-O1.o: %.c $(BUILDSTAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPCFLAGS) -O1 -o $@ -c $<

%-O2.o: %.c $(BUILDSTAMP)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPCFLAGS) -O2 -o $@ -c $<

%: %.o
	$(CC) $(CFLAGS) $(O) -o $@ $^

%-O1: %-O1.o
	$(CC) $(CFLAGS) -O1 -o $@ $^

%-O2: %-O2.o
	$(CC) $(CFLAGS) -O2 -o $@ $^

clean:
	rm -f *.o $(PROGRAMS) *.core
	rm -rf $(DEPSDIR) *.dSYM

.PHONY: all clean
