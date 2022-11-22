
CC = gcc
CFLAGS = -Wall -D_GNU_SOURCE -Wunused
LDLIBS = -pthread -lbpf -lm

all: load bpf

load: helpers.o load.o

helpers.o: helpers.c helpers.h

load.o: load.c 

.PHONY: bpf
bpf:
	make -C bpf -f Makefile

.PHONY: clean
clean:
	rm -rf load *.o
	make -C bpf -f Makefile clean
