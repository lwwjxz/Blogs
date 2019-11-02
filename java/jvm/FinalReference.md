[参考](https://github.com/lwwjxz/Blogs/tree/master/java/jvm)      
1. F类的引用，F类为重写了Object中finalize方法并且方法体不为空的类。       
1. F类在被回收是有一次自救的机会，但是虚拟机并不保证。因为如果 finalize方法中有死循环和非常耗时的操作会影响垃圾会后      
1. FinalReference会被放在ReferenceQueue中。      
