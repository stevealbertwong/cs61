PROGRAMS = ../serviceblaster ../serviceclient ../servicelookup
SERVER_PROGRAMS = serviceserver-robust serviceserver-test
# Add these as you create them
# serviceserver-process
# serviceserver-thread
# serviceserver-pool

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


