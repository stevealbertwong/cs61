PROGRAMS = testgc
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

testgc: testgc.o gc61.o
	$(CC) $(CFLAGS) -O3 -o $@ testgc.o gc61.o

clean:
	rm -f $(PROGRAMS) *.o core a.out
