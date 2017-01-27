
PROGRAMS = dobby dobby-sem

INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

dobby-sem2: dobby-sem2.o semaphores.o
		$(CC) $(CFLAGS) -o $@ $< semaphores.o -lpthread

dobby-sem: dobby-sem.o semaphores.o
		$(CC) $(CFLAGS) -o $@ $< semaphores.o -lpthread

dobby: dobby.o
		$(CC) $(CFLAGS) -o $@ $<  -lpthread

clean:
	rm -f $(PROGRAMS) *.o core a.out
