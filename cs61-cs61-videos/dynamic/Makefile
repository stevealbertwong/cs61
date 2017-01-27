PROGRAMS = testalignment
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

testalignment: testalignment.o
	$(CC) $(CFLAGS) -O3 -o $@ testalignment.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
