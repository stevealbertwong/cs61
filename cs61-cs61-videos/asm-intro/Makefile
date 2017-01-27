CFLAGS = -O3
all: a.out main.s 1.s

main.s: main.c
		$(CC) -O0 -S main.c
a.out: main.o
		$(CC) -O0 -g main.c

%.o: %.c
		$(CC) $(CFLAGS) -c $<

%.s: %.c
		$(CC) $(CFLAGS) -S $<

clean:
	rm -f *.o *.s core a.out
		

