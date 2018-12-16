1. 在unbuntu上实验`kill -3`始终不成功还是用gcore吧，不过linux上的ulimit -c 一定要打开。
1. [Linux Core Dump](http://www.cnblogs.com/hazir/p/linxu_core_dump.html)
    1. `echo 1 > /proc/sys/kernel/core_uses_pid`
    2. `echo "/tmp/corefile-%e-%p-%t" > /proc/sys/kernel/core_pattern`
2. [core dump设置](https://blog.csdn.net/star_xiong/article/details/43529637)
