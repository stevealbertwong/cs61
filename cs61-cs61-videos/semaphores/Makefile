
PROGRAMS = pingpong2-sem pingpong2-sem-soln

INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

pingpong2-sem-soln: pingpong2-sem-soln.o semaphores-soln.o
		$(CC) $(CFLAGS) -o $@ $<  -lpthread semaphores-soln.o

pingpong2-sem: pingpong2-sem.o semaphores.o
		$(CC) $(CFLAGS) -o $@ $<  -lpthread semaphores.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
