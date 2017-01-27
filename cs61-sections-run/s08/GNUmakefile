PROGRAMS = fork_1 fork_2 fork_3 fork_4 fork_5 fd_1 dup2_1 dup2_2 pipe
all: $(PROGRAMS)

include ../common/rules.mk

%.o: %.c $(BUILDSTAMP)
	$(call run,$(CC) $(CFLAGS) $(DEPCFLAGS) -o $@ -c,COMPILE,$<)

fork_1 fork_2 fork_3 fork_4 fork_5 fd_1 dup2_1 dup2_2 pipe: %: %.o
	$(call run,$(CC) $(CFLAGS) -o $@ $^,LINK $@)

clean:
	$(call run,rm -rf $(PROGRAMS) *.o *.dSYM *.core,CLEAN)

.PHONY: all clean