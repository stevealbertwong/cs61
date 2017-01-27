CFLAGS = -O3
all: 2.s 3.s 4.s 5.s 6.s 7.s 8.s 9.s
%.o: %.c
		$(CC) $(CFLAGS) -c $<

%.s: %.c
		$(CC) $(CFLAGS) -S $<

clean:
	rm -f *.o *.s core a.out
		
