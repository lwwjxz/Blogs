[参考](http://www.cnblogs.com/peida/archive/2012/12/24/2831353.html)     
1. 第四行中使用中的内存总量（used）指的是现在系统内核控制的内存数，空闲内存总量（free）是内核还未纳入其管控范围的数量。纳入内核管理的内存不见得都在使用中，还包括过去使用过的现在可以被重复利用的内存，内核并不把这些可被重新使用的内存交还到free中去，因此在linux上free内存会越来越少，但不用为此担心。
对于内存监控，在top里我们要时刻监控第五行swap交换分区的used，如果这个数值在不断的变化，说明内核在不断进行内存和swap的数据交换，这是真正的`内存不够用`了。     
1. CPU核数 = 物理CPU * 核心数。[参考](https://blog.csdn.net/dba_waterbin/article/details/8644626)   
逻辑CPU = CPU核数 * n 如果开启超线程则n=2没开则n=1    
1. [查看线程](https://www.cnblogs.com/EasonJim/p/8098217.html)      


