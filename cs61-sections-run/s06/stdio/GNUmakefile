PROGRAMS = reader writer freader fwriter
all: $(PROGRAMS)

include ../../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(CC) $(CFLAGS) -O1 $(DEPCFLAGS) -o $@ -c $<

reader: reader.o foptions.o
	$(CC) $(CFLAGS) -o $@ $^

writer: writer.o foptions.o
	$(CC) $(CFLAGS) -o $@ $^

freader: freader.o foptions.o
	$(CC) $(CFLAGS) -o $@ $^

fwriter: fwriter.o foptions.o
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(PROGRAMS) *.o *.dSYM *.core
	rm -rf $(DEPSDIR)

.PHONY: all clean
