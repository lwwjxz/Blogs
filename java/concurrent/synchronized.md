1. 锁有个专门的名字：对象监视器。  
1. jdk1.6对锁做了优化，主要就是新加了偏向锁，轻量级锁和重量级的锁，这样就避免了在所有场景下都需要用重量级索来锁定资源的产生的效率问题。    
    1. 切换线程上下文需要用户态和内核态协调工作属于比较重量级的操作。   
    1. 偏向锁永远是获取锁的第一个线程拥有。不会切换线程上下文，不会自旋。如果只是少数情况下会出现多线程的场景则偏向锁是很有用的，~~比如读多写少。~~    
    1. 轻量级锁自旋，不会切换线程上下文。  
    1. 重量级锁，会切换线程上下文。   
    1. 锁只会升级不会降级。   
    1. jdk1.6和1.7偏向锁功能是默认开启的，如果你的同步资源或代码一直都是多线程访问的，那么消除偏向锁这一步骤对你来说就是多余的。事实上，消除偏向锁的开销还是蛮大的。
    所以在你非常熟悉自己的代码前提下，大可禁用偏向锁。   
    1. 关闭偏向锁：偏向锁在Java 6和Java 7里是默认启用的，但是它在应用程序启动几秒钟之后才激活，如有必要可以使用JVM参数来关闭延迟 
    -XX：BiasedLockingStartupDelay = 0。如果你确定自己应用程序里所有的锁通常情况下处于竞争状态，可以通过JVM参数关闭偏向锁
    -XX:-UseBiasedLocking=false，那么默认会进入轻量级锁状态。     
1. 锁消除，锁粗化 [参考](https://blog.csdn.net/chenssy/article/details/54883355)    
1. synchronized与java.util.concurrent包中的ReentrantLock相比，由于JDK1.6中加入了针对锁的优化措施（见后面），使得synchronized与ReentrantLock的性能基本持平。ReentrantLock只是提供了synchronized更丰富的功能，而不一定有更优的性能，所以在synchronized能实现需求的情况下，优先考虑使用synchronized来进行同步。如果死锁synchronized也比较好排查。      
1. [好文](https://zhuanlan.zhihu.com/p/29866981)    
2. 首先，要记住这个差别，“sleep是Thread类的方法,wait是Object类中定义的方法”。尽管这两个方法都会影响线程的执行行为，但是本质上是有区别的。
Thread.sleep不会导致锁行为的改变，如果当前线程是拥有锁的，那么Thread.sleep不会让线程释放锁。如果能够帮助你记忆的话，可以简单认为和锁相关的方法都定义在Object类中，因此调用Thread.sleep是不会影响锁的相关行为。
Thread.sleep和Object.wait都会暂停当前的线程，对于CPU资源来说，不管是哪种方式暂停的线程，都表示它暂时不再需要CPU的执行时间。OS会将执行时间分配给其它线程。区别是，调用wait后，需要别的线程执行notify/notifyAll才能够重新获得CPU执行时间。wait和notify只有在持有锁的时候才能调用。wait被notify后重新获取锁后从wait语句后接着执行，且不会有线程安全问题因为执行wait释放锁的时候肯定会保证可见性和禁止重排序的。
 

