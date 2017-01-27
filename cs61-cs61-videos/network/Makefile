PROGRAMS = serviceclient servicelookup
SERVER_PROGRAMS = serviceserver-01 serviceserver-02
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


