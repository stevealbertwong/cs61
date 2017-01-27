
PROGRAMS = pingpong pingpong2 pingpong3 pingpong4 pingpong5 \
		   pingpong6 pingpong7

INCLUDES = -I.

CFLAGS = -g -O0 -Wall $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

$(PROGRAMS): %: %.o
		$(CC) $(CFLAGS) -o $@ $< 

clean:
	rm -f $(PROGRAMS) *.o core a.out
