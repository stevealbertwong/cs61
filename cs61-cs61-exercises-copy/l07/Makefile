all: 20.s 21.s 22.s 23.s 24.s 25.s 26.s

CFLAGS = -S -O3

20.s: 20.c
		$(CC) -S -O0 $<

21.s: 21.c
		$(CC) -S -O1 $<

%.s: %.c
		$(CC) $(CFLAGS) $<


clean:
		rm -rf *.s *.o a.out core
