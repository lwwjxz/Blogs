1. 在jvm的概念模型里内存区域可分为堆内存，栈内存，程序计数器，本地方法栈，方法区等。其中堆内存和方法区是所有的线程公用的，其他为线程私有的。作为一般
的程序员只需要关注堆内存和栈内存即可。   
1. 栈内存可抛出两种异常StackOverFlowError(线程请求的栈深度大于虚拟机所允许的深度)，OutOfMemoryError(栈无法申请到足够的内存).  
1. HotSpot 虚拟机种把栈内存和本地方法栈合二为一。  
1. 方法区与java堆一样是各个线程共享的内存区域，用于加载类信息，常量，静态变量即时编译器编译后的代码能。HotSpot虚拟机中很多人愿意把方法区成为永久带。  
1. 直接内存避免了数据在jvm内存Native内存中来回的切换。   
