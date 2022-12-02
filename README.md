


you can check 'attr.kern_version' is read from linux-x.x.x/usr/include/linux/version.h file ‘LINUX_VERSION_CODE’

```
echo 'r:myretprobe do_sys_open' >> /sys/kernel/debug/tracing/kprobe_events
echo /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable
echo 1 /sys/kernel/debug/tracing/tracing_on
cat /sys/kernel/debug/tracing/events/kprobes/myretprobe/id
cat /sys/kernel/debug/tracing/trace_pipe 
```


