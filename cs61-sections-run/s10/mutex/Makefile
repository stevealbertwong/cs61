CC=gcc
CFLAGS=-Wall -pthread -O0

all: thebest withdraw

thebest: thebest.c
	$(CC) $(CFLAGS) -o $@ $^

withdraw: withdraw.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm thebest
	rm withdraw
