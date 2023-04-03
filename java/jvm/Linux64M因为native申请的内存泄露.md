JVM 的内存大概分为下面这几个部分   
堆（Heap）：eden、metaspace、old 区域等    
线程栈（Thread Stack）：每个线程栈预留 1M 的线程栈大小    
非堆（Non-heap）：包括 code_cache、metaspace 等    
堆外内存：unsafe.allocateMemory 和 DirectByteBuffer 申请的堆外内存    
native （C/C++ 代码）申请的内存    
还有 JVM 运行本身需要的内存，比如 GC 等。    

https://github.com/lwwjxz/Blogs/blob/master/java/jvm/linux%2064M.pdf
