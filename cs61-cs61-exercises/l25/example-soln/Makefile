PROGRAMS = serviceblaster serviceclient servicelookup
SERVER_PROGRAMS = serviceserver serviceserver-process serviceserver-thread \
	serviceserver-pool
# Add these as you create them

ALLPROGRAMS = $(PROGRAMS) $(SERVER_PROGRAMS)

INCLUDES = -I.

O = 2
CFLAGS = -g -O$(O) -Wall $(INCLUDES)

all: $(PROGRAMS) $(SERVER_PROGRAMS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

$(PROGRAMS): %: %.o
		$(CC) $(CFLAGS) -o $@ $< 

$(SERVER_PROGRAMS): %: %.o
		$(CC) $(CFLAGS) -o $@ $< -lpthread

clean:
	rm -f $(ALLPROGRAMS) *.o *.dSYM *.core

.PHONY: all clean


