all: 1.s 1a.s 1b.s 1c.s 2a.s 2b.s 2c.s 3.s 4.s 5.s 6.s 7.s 8.s

CFLAGS = -S -O3

%.s: %.c
		$(CC) $(CFLAGS) $<


clean:
		rm -rf *.s *.o a.out core
