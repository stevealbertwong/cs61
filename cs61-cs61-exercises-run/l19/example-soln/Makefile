
PROGRAMS = pingpong2-mutex pingpong2-cv pingpong2-cvs dobby-soln

INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

$(PROGRAMS): %: %.o
		$(CC) $(CFLAGS) -o $@ $<  -lpthread

clean:
	rm -f $(PROGRAMS) *.o core a.out
