CFLAGS = -O3
all: 16.s 17.s 18.s 19.s 19b.s fiba.s fibb.s
%.o: %.c
		$(CC) $(CFLAGS) -c $<

fiba.s: fiba.c
		$(CC) -S -O0 -o fiba.s $<

fibb.s: fibb.c
		$(CC) -S -O0 -o fibb.s $<


19b.s: 19.c
		$(CC) -S -O0 -o 19b.s $<

%.s: %.c
		$(CC) $(CFLAGS) -S $<

clean:
	rm -f *.o *.s core a.out
		
