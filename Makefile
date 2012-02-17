SRCS = utf8.c 

OBJS = $(SRCS:%.c=%.o)
DOBJS = $(SRCS:%.c=%.do)

ifneq ($(MAKECMDGOALS),debug)
XOBJS = $(OBJS)
else
XOBJS = $(DOBJS)
endif

FLAGS = -Wall -Wno-strict-aliasing $(CFLAGS)

DEBUGFLAGS = -ggdb3 -DDEBUG
SHIPFLAGS = -O3 -DNDEBUG -falign-functions -momit-leaf-frame-pointer

DEBUGFLAGS += $(FLAGS)
SHIPFLAGS += $(FLAGS)

default: release

%.o: %.c
	$(CC) $(SHIPFLAGS) -c $< -o $@
%.do: %.c
	$(CC) $(DEBUGFLAGS) -c $< -o $@

release debug: libcutef8.a

libcutef8.a: $(XOBJS)
	rm -rf $@
	ar -rcs $@ $^

clean:
	rm -f *.o
	rm -f *.do
	rm -f *.a
	rm -f *~ *#
	rm -f core*
	rm -f libcutef8.a
