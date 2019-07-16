[参考](https://tier1app.files.wordpress.com/2014/12/outofmemoryerror2.pdf)
出现的频率依次递减


|原因|解决方法|
--|--|
代码没问题确实需要更多的内存|优化代码，如果无法优化只能修改xmx了
内存泄漏|修复代码
过多使用finalizer，或者不正确的实现finalize方法，比如finalize方法耗时太长|调大内存或优化代码
JVM用98%的时间回收了不到2%的堆内存，因此预测到内存即将耗尽，抛出OOM异常来提示内存不足，给用户一个警告信息|Oracle给的解决方法是提高堆内存，也可以用-XX:-UseGCOverheadLimit参数来关闭这个异常警告
加载class太多引起Metaspace区溢出，不是class对象，因为class对象是在堆中加载的|不能优化代码的话只能加大内存了
生成过多的线程|不能优化代码的话可以<br>1. 加大机器的内存，并不是堆内存。以为栈内存是直接是向操作系统申请的。 <br>2.在操作系统层面限制线程的数量ulimit -a max user processes (-u) 1800  <br> 3.调小每个线程栈内存的大小 -Xss 
线程池中的无界队列，如果任务耗时很长，可能导致等待队列越积越多最终导致OOM |1. 优化代码<br> 2. 借助redis等实现队列
