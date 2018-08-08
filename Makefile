#########################################
#author   : yuanwei
#date     : 20180808
#function : for arm-linux
########################################
ARM_GNU_BIN := /package/usr/local/arm/3.4.1/bin
ARM_PREFIX  := $(ARM_GNU_BIN)/arm-linux-

# arm-linux-  corss-compile tools
OBJDUMP     := $(ARM_PREFIX)objdump
GCC         := $(ARM_PREFIX)gcc
ADDR2LINE   := $(ARM_PREFIX)addr2line
AR          := $(ARM_PREFIX)ar
AS          := $(ARM_PREFIX)as
CPP         := $(ARM_PREFIX)cpp
GPLUSPLUS   := $(ARM_PREFIX)g++
GCC         := $(ARM_PREFIX)gcc
LD          := $(ARM_PREFIX)ld
NM          := $(ARM_PREFIX)nm
OBJCOPY     := $(ARM_PREFIX)objcopy
OBJDUMP     := $(ARM_PREFIX)objdump
RANLIB      := $(ARM_PREFIX)ranlib
READELF     := $(ARM_PREFIX)readelf
SIZE        := $(ARM_PREFIX)size
STRINGS     := $(ARM_PREFIX)strings
STRIP       := $(ARM_PREFIX)strip

ifeq ($(origin V),command line)
    VERBOSE := $(V)
endif
ifndef VERBOSE
    VERBOSE := 0
endif

ifeq ($(VERBOSE),1)
    Q :=
else
    Q := @
endif

GCC := gcc
objs += main.o

CFLAGS := -Werror
all: $(objs)
	$(Q)$(GCC) $^ -o $@

PHONY := all

# depends-file output
%.o: CFLAGS += -MD -MF .$@.d
%.o:%.c
	$(Q)$(GCC) $(CFLAGS) -c -o $@ $<

%.o:%.S
	$(Q)$(GCC) $(CFLAGS) -c -o $@ $<

objs-dep := $(patsubst %,.%.d,$(objs))
-include $(wildcard $(objs-dep))

clean:
	rm -f $(objs)

PHONY += clean

distclean:
	rm -f $(objs) $(objs-dep)

.PHONY : $(PHONY)
