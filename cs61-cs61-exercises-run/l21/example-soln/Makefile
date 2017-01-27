
PROGRAMS = philosophers

INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

philosophers: philosophers.o semaphores.o
		$(CC) $(CFLAGS) -o $@ $< semaphores.o -lpthread

clean:
	rm -f $(PROGRAMS) *.o core a.out
