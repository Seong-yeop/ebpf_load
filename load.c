#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#include "helpers.h"

int main() {
  int bpf_fd = -1;
  
   bpf_fd = load_bpf_program_byte("bpf/test_bpf");
   printf("bpf_fd: %d\n", bpf_fd);

   return 0;
}
