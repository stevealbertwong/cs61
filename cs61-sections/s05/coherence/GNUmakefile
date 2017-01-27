PROGRAMS = readbytes freadbytes writebytes fwritebytes
all: $(PROGRAMS) data

include ../../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) -O1 $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

readbytes freadbytes writebytes fwritebytes: %: %.o
	$(call run,$(CC) $(CFLAGS) -o $@ $^,LINK $@)

data: always
	$(call run,yes 6 | tr -d '\n' | head -c 1024 > data,CREATE data)

clean:
	$(call run,rm -f $(PROGRAMS) *.o *.dSYM *.core,CLEAN)
	$(call run,rm -rf $(DEPSDIR))

.PHONY: all clean
