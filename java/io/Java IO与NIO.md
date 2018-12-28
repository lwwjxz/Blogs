1. [参考](https://github.com/Snailclimb/JavaGuide/blob/master/Java%E7%9B%B8%E5%85%B3/Java%20IO%E4%B8%8ENIO.md#%E4%B8%80-java-io%EF%BC%8C%E7%A1%AC%E9%AA%A8%E5%A4%B4%E4%B9%9F%E8%83%BD%E5%8F%98%E8%BD%AF)   
2. [Scatter/Gather](http://ifeve.com/java-nio-scattergather/)
3. [内存映射](https://blog.csdn.net/Evankaka/article/details/48464013)
    1. java通过java.nio包来支持内存映射IO。
    1. 内存映射文件主要用于性能敏感的应用，例如高频电子交易平台。
    2. 通过使用内存映射IO，你可以将大文件加载到内存。
    1. 内存映射文件可能导致页面请求错误，如果请求页面不在内存中的话。
    1. 映射文件区域的能力取决于于内存寻址的大小。在32位机器中，你不能访问超过4GB或2 ^ 32（以上的文件）。
    1. 内存映射IO比起Java中的IO流要快的多。
    1. 加载文件所使用的内存是Java堆区之外，并驻留共享内存，允许两个不同进程共享文件。
    1. 内存映射文件读写由操作系统完成，所以即使在将内容写入内存后java程序崩溃了，它将仍然会将它写入文件直到操作系统恢复。
    1. 出于性能考虑，推荐使用直接字节缓冲而不是非直接缓冲。
    1. 不要频繁调用MappedByteBuffer.force()方法，这个方法意味着强制操作系统将内存中的内容写入磁盘，所以如果你每次写入内存映射文件都调用force()方法，你将不会体会到使用映射字节缓冲的好处，相反，它(的性能)将类似于磁盘IO的性能。
    1. 万一发生了电源故障或主机故障，将会有很小的机率发生内存映射文件没有写入到磁盘，这意味着你可能会丢失关键数据。

4. 零拷贝 [1](https://www.cnblogs.com/z-sm/p/6547709.html) [2](http://www.saily.top/2017/09/12/nio7/) 
    1. https://www.ibm.com/developerworks/cn/linux/l-cn-zerocopy1/index.html     
    1. https://www.ibm.com/developerworks/cn/linux/l-cn-zerocopy2/index.html
1. [Java NIO AsynchronousFileChannel异步文件通](http://wiki.jikexueyuan.com/project/java-nio-zh/java-nio-asynchronousfilechannel.html)
    1. 跟ajax有点像。
 