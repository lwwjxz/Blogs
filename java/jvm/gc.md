本文为《深入理解java虚拟机》的笔记    
1. 判断对象是否已死？   
    1. 引用计数法：主流的java虚拟机都用不该方法应为对象互相引用的问题很难解决。  
    1. 可达性分析法：当一个对象到GC Roots 间没有任何引用链则认为该对象已死。在java中GC Roots 包括下面几种:    
        1. 栈中引用的对象。  
        1. 方法区中类静态属性引用的对象。`static String`   
        1. 方法区中常量引用的对象。`static final String`,`"name",5 等常量`   
        1. 本地方法栈中JNI(即Native方法引用的对象)   
    1. JDK1.2 后把引用分为强引用，软引用，弱引用和虚引用。关于虚引用的理解[参考](http://www.importnew.com/21206.html)中的WHY 和 HOW。   
    1. 不可达不一定会被回收，还需要被认定的不需要执行finalize()方法。如果执行过才会回收。   
 1. 方法区的回收，大量使用动态代理，反射，CGlib等 byteCode框架，动态生成JSP以及OSGI这里频繁自定义classLoder的场景需要虚拟机具有卸载类的功能
 以保证永久带不会溢出。  
 1. 垃圾回收算法:
    1. 标记清除法  
    1. 复制算法，现在的商业虚拟机中都采用这种算法来来回收新生代。Eden和Survivor取的比例是8：1.  
    1. 标记整理算法，分代回收中的老年代一般采用这种算法。因为老年带的对象一般存活率较高 ，复制算法的效率较低。   
 1. 枚举根节点会stop-the-word，即使在号称（几乎）不会发生停顿的CMS收集器中也一样
 1. [怎么判定频繁](https://stackoverflow.com/questions/12599044/what-the-frequency-of-the-garbage-collection-in-java);
    1. 1秒内两次异常 new gc。
    1. full gc 当然是越少越好
1. -XX:+PrintGCApplicationStoppedTime  它就会把全部的JVM停顿时间（不只是GC），打印在GC日志里。
1. [finalize](https://bijian1013.iteye.com/blog/2288223)    
    1.  当对象变成(GC Roots)不可达时，GC会判断该对象是否覆盖了finalize方法，若未覆盖，则直接将其回收。否则，若对象未执行过finalize方法，将其放入F-Queue队列，由一低优先级线程执行该队列中对象的finalize方法。执行finalize方法完毕后，GC会再次判断该对象是否可达，若不可达，则进行回收，否则，对象“复活”。    
    1. 注意finalize方法不能耗时太长，否则队列可能阻塞，最终导致内存溢出。


        
        
