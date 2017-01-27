
PROGRAMS = cat_wrapper_out cat_wrapper_in
INCLUDES = -I.

CFLAGS = -g -O0 -Wall -DPART2 $(INCLUDES)

all: $(PROGRAMS)

%.o:%.c
	$(CC) $(CFLAGS) -c $<

$(PROGRAMS): %: %.o
		$(CC) $(CFLAGS) -o $@ $< 

clean:
	rm -f $(PROGRAMS) *.o core a.out
