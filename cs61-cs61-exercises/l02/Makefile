PROGRAMS = main0 main1 main2 main3 main4 main5 main6 main7 main8
INCLUDES = -I.

CFLAGS = -g -O3 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

main0: main0.o
	$(CC) $(CFLAGS) -o $@ main0.o

main1: main1.o
	$(CC) $(CFLAGS) -o $@ main1.o

main2: main2.o
	$(CC) $(CFLAGS) -o $@ main2.o

main3: main3.o
	$(CC) $(CFLAGS) -o $@ main3.o

main4: main4.o
	$(CC) $(CFLAGS) -o $@ main4.o

main5: main5.o hexdump.o
	$(CC) $(CFLAGS) -o $@ main5.o hexdump.o

main6: main6.o hexdump.o
	$(CC) $(CFLAGS) -o $@ main6.o hexdump.o

main7: main7.o hexdump.o
	$(CC) $(CFLAGS) -o $@ main7.o hexdump.o

main8: main8.o hexdump.o
	$(CC) $(CFLAGS) -o $@ main8.o hexdump.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
