PROGRAMS = w01_sync w02_syscall w03_stdio \
		   w01_syncblock w02_syscallblock w03_stdioblock
INCLUDES = -I.

CFLAGS = -g -O3 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

w01_sync: w01_sync.o
	$(CC) $(CFLAGS) -o $@ w01_sync.o

w01_syncblock: w01_syncblock.o
	$(CC) $(CFLAGS) -o $@ w01_syncblock.o

w02_syscall: w02_syscall.o
	$(CC) $(CFLAGS) -o $@ w02_syscall.o

w02_syscallblock: w02_syscallblock.o
	$(CC) $(CFLAGS) -o $@ w02_syscallblock.o

w03_stdio: w03_stdio.o
	$(CC) $(CFLAGS) -o $@ w03_stdio.o

w03_stdioblock: w03_stdioblock.o
	$(CC) $(CFLAGS) -o $@ w03_stdioblock.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
