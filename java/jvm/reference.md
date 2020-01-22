1. [参考](https://www.cnblogs.com/nullzx/p/7406151.html)     
  1. WeakHashMap中Entry是WeakReference的子类，key是WeakReference指向的对象，如果key被回收则对应的Entry会被放到ReferenceQueue里，每次get或set的时候都会从ReferenceQueue取出对应的Entry并删除。 比如key可以保存某个socket连接，value对应的socket连接对应的用户信息等。当socket断开时对应的entry包括用户信息就会被删除    
 [JVM 源码分析之 FinalReference 完全解读](https://www.infoq.cn/article/jvm-source-code-analysis-finalreference)    
  1. jvm在实例化重写了finalize方法的对象时会用一个Finalizer对象指向该对象，在该对象被收前(所以不是所有refrence对象都需要在其指向的对象被回收后才会被放在对应的queue里)对应的Finalizer对象会被放在queue里并且有一个优先级别比较低的线程执行finalize方法，执行完后Finalizer对象会从queue删除，所以被回收的对象只能自救一次，因为对象只有在初始化的时候才能被Finalizer对象引用，如果不被Finalizer对象就不会被放在queue里就不会重新执行finalize方法了。    
1. [Java Reference核心原理分析](https://juejin.im/post/5d9c61d0e51d45780c34a83a#heading-3)  
  1. 从DirectByteBuffer部分可以看出实际的对象被虚引用引用的对象会被GC回收不需要等待虚引用本身被回收。   
1. 虚引用和弱引用的不同，虚引用对应的对象不会被通过虚引用get到只是在对应的被对象被回收后做相应的事情，而弱引对应的对象在没被GC回收以前会被会被get到。    
  1. 虚/幽灵引用重写了Reference的get方法，逻辑为写死返回null。虽然对象还在但是get不到所以叫做幽灵引用。   

