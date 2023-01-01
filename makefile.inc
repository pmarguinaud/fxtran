
ifneq ($(DEB_CFLAGS), )
CFLAGS_USER=$(DEB_CFLAGS)
endif

ifneq ($(DEB_LDFLAGS), )
LDFLAGS_USER=$(DEB_LDFLAGS)
endif

OPT=2

ifeq ($(DEBUG), 1)
  OPT=0
endif

CFLAGS=-Wall -g -fPIC -I$(ROOT)/src/cpp -I$(ROOT)/include -O$(OPT) $(CFLAGS_USER)
LDFLAGS=$(LDFLAGS_USER)

