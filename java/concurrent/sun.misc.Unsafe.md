[参考](http://xiaobaoqiu.github.io/blog/2014/11/08/jie-mi-sun-dot-misc-dot-unsafe/)     
1. Java最初被设计为一种安全的受控环境.尽管如此,Java HotSpot还是包含了一个“后门”,它提供了一些可以直接操控内存和线程的低层次操作.这个后门类就是sun.misc.Unsafe,它被JDK广泛用于自己的包中,如java.nio和java.util.concurrent.但是丝毫不建议在生产环境中使用这个后门.因为这个API十分不安全、不轻便、而且不稳定.这个不安全的类提供了一个观察HotSpot JVM内部结构并且可以对其进行修改.     
1. 常用方法解释[参考](https://www.cnblogs.com/daxin/p/3366606.html)     
