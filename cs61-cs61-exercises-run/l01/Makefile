PROGRAMS = fib hello
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

fib: fib.o limit.o
	$(CC) $(CFLAGS) -O3 -o fib fib.o limit.o

hello: hello.o
	$(CC) $(CFLAGS) -O3 -o $@ hello.o

clean:
	rm -f $(PROGRAMS) *.o
