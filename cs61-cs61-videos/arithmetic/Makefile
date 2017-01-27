PROGRAMS = signs signs2 signs3 signs4
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

signs: signs.o hexdump.o
	$(CC) $(CFLAGS) -O3 -o $@ signs.o hexdump.o

signs2: signs2.o hexdump.o
	$(CC) $(CFLAGS) -O3 -o $@ signs2.o hexdump.o

signs3: signs3.o hexdump.o
	$(CC) $(CFLAGS) -O3 -o $@ signs3.o hexdump.o

signs4: signs4.o hexdump.o
	$(CC) $(CFLAGS) -O3 -o $@ signs4.o hexdump.o

clean:
	rm -f $(PROGRAMS) *.o a.out core
