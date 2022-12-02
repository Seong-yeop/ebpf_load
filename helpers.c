#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
 
#include <linux/perf_event.h>

#include "helpers.h"

unsigned char test1[1024] = {
0xb7, 0x01, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00,
0x6b, 0x1a, 0xfc, 0xff, 0x00, 0x00, 0x00, 0x00,
0xb7, 0x01, 0x00, 0x00, 0x72, 0x6c, 0x64, 0x21,
0x63, 0x1a, 0xf8, 0xff, 0x00, 0x00, 0x00, 0x00,
0x18, 0x01, 0x00, 0x00, 0x48, 0x65, 0x6c, 0x6c,
0x00, 0x00, 0x00, 0x00, 0x6f, 0x20, 0x57, 0x6f,
0x7b, 0x1a, 0xf0, 0xff, 0x00, 0x00, 0x00, 0x00,
0xbf, 0xa1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x07, 0x01, 0x00, 0x00, 0xf0, 0xff, 0xff, 0xff,
0xb7, 0x02, 0x00, 0x00, 0x0e, 0x00, 0x00, 0x00,
0x85, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00,
0xb7, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x95, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

int load_bpf_program(char *path) {
  struct bpf_object *obj;
  int ret, progfd;

  ret = bpf_prog_load(path, BPF_PROG_TYPE_KPROBE, &obj, &progfd);
  if (ret) {
    printf("Failed to load bpf program\n");
    exit(1);
  }

  return progfd;
}

int load_bpf_program_byte(char *path) {

  int pfd;
  int bfd;
  int efd;
  int n;
  int ret;
  unsigned char buf[1024] = {};
  struct bpf_insn *insn;
  union bpf_attr attr = {};
  unsigned char log_buf[4096] = {};
   
  struct perf_event_attr pattr = {};

  bfd = open(path, O_RDONLY);
  if (bfd < 0)
  {
    printf("open eBPF program error: %s\n", strerror(errno));
    exit(-1);
  }
  n = read(bfd, buf, 1024);
  for (int i = 0; i < n; ++i)
  {
    printf("0x%02x, ", buf[i]);
    if ((i+1) % 8 == 0)
      printf("\n");
  }
  printf("eBPF program size: %d\n", n);
  printf("\n");
  close(bfd);

  insn = (struct bpf_insn*)buf;
  attr.prog_type = BPF_PROG_TYPE_KPROBE;
  attr.insns = (unsigned long)insn;
  attr.insn_cnt = n / sizeof(struct bpf_insn);
  attr.license = (unsigned long)"GPL";
  attr.log_size = sizeof(log_buf);
  attr.log_buf = (unsigned long)log_buf;
  attr.log_level = 1;
  attr.kern_version = 329728;

  pfd = syscall(SYS_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
  if (pfd < 0)
  {
    printf("bpf syscall error: %s\n", strerror(errno));
    printf("log_buf = %s\n", log_buf);
    exit(-1);
  }    
  pattr.type = PERF_TYPE_TRACEPOINT;
  pattr.sample_type = PERF_SAMPLE_RAW;
  pattr.sample_period = 1;
  pattr.wakeup_events = 1;
  pattr.config = 1804;
  pattr.size = sizeof(pattr);
  efd = syscall(SYS_perf_event_open, &pattr, -1, 0, -1, 0);
  if (efd < 0)
  {
    printf("perf_event_open error: %s\n", strerror(errno));
    exit(-1);
  }
  ret = ioctl(efd, PERF_EVENT_IOC_ENABLE, 0);
  if (ret < 0)
  {
    printf("PERF_EVENT_IOC_ENABLE error: %s\n", strerror(errno));
    exit(-1);
  }
  ret = ioctl(efd, PERF_EVENT_IOC_SET_BPF, pfd);
  if (ret < 0)
  {
    printf("PERF_EVENT_IOC_SET_BPF error: %s\n", strerror(errno));
    exit(-1);
  }
  while(1);


  return pfd;
}
