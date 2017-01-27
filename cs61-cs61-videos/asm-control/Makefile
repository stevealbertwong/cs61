CFLAGS = -O3
all: 12.s 13.s 14.s 15.s
%.o: %.c
		$(CC) $(CFLAGS) -c $<

%.s: %.c
		$(CC) $(CFLAGS) -S $<

clean:
	rm -f *.o *.s core a.out
		
