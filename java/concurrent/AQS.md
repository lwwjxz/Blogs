1. [参考](http://www.cnblogs.com/yulinfeng/p/6874240.html)     
    1. AQS是一个用于构建锁和同步器的框架。例如在并发包中的ReentrantLock、Semaphore、CountDownLatch、ReentrantReadWriteLock等都是基于AOS构建，这些锁都有一个特点，都不是直接扩展自AQS，而是都有一个内部类继承自AQS。为什么会这么设计而不是直接继承呢？简而言之，锁面向的是使用者，同步器面向的是线程控制(可以理解为锁的实现方案)，在锁的实现中聚合同步器而不是直接继承AQS很好的隔离了二者所关注的领域。         
    1. 这个在AQS定义的方法`tryAcquire`表示该方法保证线程安全的获取同步状态   
    1. `enq(final Node node)`方法中的compareAndSetHead不太理解为什么要初始化一个空的Node，而不是直接将当期Node指向head和tail？ 
    原因还不清楚但是以下实时有利于理解
        1. acquireQueued方法中判断前一个节点是head就去tryacquire因为有可能是前一个节点调用的unpark方法。
    1. 终于知道为什么叫acquire和tryacquire了，因为acquire的就是通过不停的tryacquire来实现的。   
1. [参考](https://www.cnblogs.com/waterystone/p/4920797.html)     
    1. 自旋锁会消耗CPU自由在确定能快速获得锁的场景才适合使用自旋锁，AQS中的addWaiter方法就比较适合自旋因为往tail添加一个节点是一个非常轻量级的操作所以不会阻塞太长时间。   
    1. 为什么需要selfInterrupt()因为如果Thread.currentThread().isInterrupted()为true时LockSupport.park();方法无效。所以要用Thread.interrupted();
    清除掉并用selfInterrupt()重新设置。      
    1. synchronized 和 AQS的区别      
        1. 功能丰富，synchronized只是个非公平锁。synchronized功能单一相当于一个不公平的可重入锁，很难满足各种各样的场景。  
        1. synchronized是重量级锁而AQS用的LockSupport.park()比较轻量级。   
        1. 没有性能问题，满足使用场景时应该使用synchronized因为[参考](https://blog.csdn.net/fw0124/article/details/6672522)     
            1. 用起来简单。   
            1. synchronized 相比于Lock不用在finally代码块中释放锁。    
            1. 当 JVM 用 synchronized 管理锁定请求和释放时，JVM 在生成线程转储时能够包括锁定信息。这些对调试非常有价值，因为它们能标识死锁或者其他异常行为的来源。 Lock 类只是普通的类，JVM 不知道具体哪个线程拥有 Lock 对象。     
    1. [参考](https://blog.csdn.net/xiaoxufox/article/details/51353679)condition 是把当前线程从AQS同步等待队列中释放，放到condition的等待队列。并把waitStatus设置为-2。跟Object.await()相比一个锁可以有多个condition，这样唤醒的时候就可以有针对性，比如生产者消费者模式生产者和消费者就可以有不同的condition。   
1. 获取锁的过程不是原子的前面的操作为后面操作的前提，所有说后面的操作发生的时候前提条件可能已经发生变化了。这一切都是有CAS把关的。   
1. 公平锁并不是百分之百公平，只是接近百分之百，可以认为是百分之百，因为就ReentrantLock来看当排队的过程和获取锁的过程都不是绝对公平的。   
1. AQS排它锁[参考](http://www.infoq.com/cn/articles/jdk1.8-abstractqueuedsynchronizer#anch112663)    
    1. AQS中有一个volatile的环境变量state
    1. tryAcquire方法试图用cas修改该对象如果修改成功则获取锁，如果修改失败则排队。
    1. 当把当前线程放在队尾的时候也是用的cas不断重试保证了线程安全。   
    1. 第一个获取锁的线下获取锁以后head和tail都是null。  
    1. 当线程进入队列时如果队列是空的则head和tail都是当前线程。  
    1. 线程进入队列后首先尝试再一次获取锁，如果失败再判断是不是应该重新获取锁还是park。为什么要重新获取锁呢？因为持有锁的线程在释放锁的时候有可能head还未null(入队的操作还没有结束)也许还有别的可能吧？这块没看清楚呢。
    1. 当线程释放锁时会通知队列中的头部线程，unpark。有可能通知不到，因为可能别的线程正往队列里放所以还没有完全放进去。    
    1. 共享锁就是大家一起获取的锁。CountdownLatch就是利用的共享锁，当state==0时所有在队列列await的线程都可以获取锁。
    1. acquire返回获取锁的过程中忽略中断，acquireInterruptibly方法获取锁的过程中相应中断。tryAcquireNanos获取锁的过程中加入时间限制，超过一定的时间就不在获取锁直接返回有parkNanos的支持。LockSupport调用的是原生方法。    
    1. 非公平读写算肯能会饿死写线程，解决办法就是将锁设置为公平的。    
    
            
    
    
