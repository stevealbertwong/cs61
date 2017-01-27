CC=gcc
CFLAGS=-Wall -pthread -O0

all: eternal_process timed_pipe

timed_pipe: timed_pipe.c
	$(CC) $(CFLAGS) -o $@ $^

eternal_process: eternal_process.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm eternal_process 
	rm timed_pipe
