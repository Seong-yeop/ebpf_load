llvm-objdump -arch-name=bpf -S test_bpf.o
dd if=./test_bpf.o  of=test_bpf bs=1 count=104 skip=64
