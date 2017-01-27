GCC ?= $(shell if gcc-mp-4.8 --version | grep gcc >/dev/null; then echo gcc-mp-4.8; \
	elif gcc-mp-4.7 --version | grep gcc >/dev/null; then echo gcc-mp-4.7; \
	else echo gcc; fi 2>/dev/null)

ifeq ($(PREFER_GCC),1)
CC = $(shell if $(GCC) --version | grep gcc >/dev/null; then echo $(GCC); \
	else echo clang; fi 2>/dev/null)
else
CC = $(shell if clang --version | grep LLVM >/dev/null; then echo clang; \
	else echo $(GCC); fi 2>/dev/null)
endif

CLANG := $(shell if $(CC) --version | grep LLVM >/dev/null; then echo 1; else echo 0; fi)

CFLAGS = -std=gnu99 -m32 -W -Wall -g $(DEFS)
DEPCFLAGS = -MD -MF $(DEPSDIR)/$*.d -MP

DEPSDIR := .deps
BUILDSTAMP := $(DEPSDIR)/rebuildstamp
DEPFILES := $(wildcard $(DEPSDIR)/*.d)
ifneq ($(DEPFILES),)
include $(DEPFILES)
endif

ifneq ($(DEP_CC),$(CC) $(CFLAGS) $(DEPCFLAGS) $(O))
DEP_CC := $(shell mkdir -p $(DEPSDIR); echo >$(BUILDSTAMP); echo "DEP_CC:=$(CC) $(CFLAGS) $(DEPCFLAGS) $(O)" >$(DEPSDIR)/_cc.d)
endif

V = 0
ifeq ($(V),1)
run = $(1) $(3)
xrun = /bin/echo "$(1) $(3)" && $(1) $(3)
else
run = @$(if $(2),/bin/echo "  $(2) $(3)" &&,) $(1) $(3)
xrun = $(if $(2),/bin/echo "  $(2) $(3)" &&,) $(1) $(3)
endif

CLEANASM = 1
ifeq ($(CLEANASM),1)
cleanasm = perl -ni -e 'print if !/^(?:\# BB|\s+\.cfi|\s+\.p2align|\s+\# =>This)/' $(1)
else
cleanasm = :
endif

$(BUILDSTAMP):
	@mkdir -p $(@D)
	@echo >$@

always:
	@:

clean-hook:
	@:

.PHONY: always clean-hook
.PRECIOUS: %.o
