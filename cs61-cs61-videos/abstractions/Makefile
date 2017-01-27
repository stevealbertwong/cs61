PROGRAMS = infinite mexplore hello
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

mexplore: mexplore.o hexdump.o
	$(CC) $(CFLAGS) -O3 -o $@ mexplore.o hexdump.o

infinite: infinite.o
	$(CC) $(CFLAGS) -O3 -o $@ infinite.o

hello: hello.o
	$(CC) $(CFLAGS) -O3 -o $@ hello.o

clean:
	rm -f $(PROGRAMS) *.o
