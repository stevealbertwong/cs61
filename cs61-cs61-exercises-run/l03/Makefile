PROGRAMS = charsize charval carray carray2 iarray iexperiment parith layout
INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

charsize: charsize.o hexdump.o
	$(CC) $(CFLAGS) -o $@ charsize.o hexdump.o

charval: charval.o hexdump.o
	$(CC) $(CFLAGS) -o $@ charval.o hexdump.o

carray: carray.o hexdump.o
	$(CC) $(CFLAGS) -o $@ carray.o hexdump.o

carray2: carray2.o hexdump.o
	$(CC) $(CFLAGS) -o $@ carray2.o hexdump.o

iarray: iarray.o hexdump.o
	$(CC) $(CFLAGS) -o $@ iarray.o hexdump.o

iexperiment: iexperiment.o hexdump.o
	$(CC) $(CFLAGS) -o $@ iexperiment.o hexdump.o

layout: layout.o hexdump.o
	$(CC) $(CFLAGS) -o $@ layout.o hexdump.o

parith: parith.o hexdump.o
	$(CC) $(CFLAGS) -o $@ parith.o hexdump.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
