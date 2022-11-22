LLC ?= llc
CLANG ?= clang
CC ?= gcc

BPF_CFLAGS ?= -I$(LIBBPF_DIR)/build/usr/

all: test_bpf


test_bpf: test_bpf.o
	llvm-objdump -arch-name=bpf -S $<
	dd if=./$<  of=test_bpf bs=1 count=104 skip=64

test_bpf.o: test_bpf.c 


%.o: %.c
	$(CLANG) -S \
	    -target bpf \
	    -D __BPF_TRACING__ \
	    $(BPF_CFLAGS) \
	    -Wall \
	    -Wno-unused-value \
	    -Wno-pointer-sign \
	    -Wno-compare-distinct-pointer-types \
	    -Werror \
	    -O2 -emit-llvm -c -g -o ${@:.o=.ll} $<
	$(LLC) -march=bpf -filetype=obj -o $@ ${@:.o=.ll}


.PHONY: clean
clean: 
	rm -rf *.o test_bpf
