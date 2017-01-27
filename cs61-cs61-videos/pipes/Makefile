PROGRAMS = pipedemo
INCLUDES = -I.

CFLAGS = -g $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
		$(CC) $(CFLAGS) -c $<

pipedemo: pipedemo.o
	$(CC) $(CFLAGS) -O3 -o $@ $<

clean:
	rm -f $(PROGRAMS) *.o core a.out
