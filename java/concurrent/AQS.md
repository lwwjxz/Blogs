1. [参考](http://www.cnblogs.com/yulinfeng/p/6874240.html)     
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
    1. [参考](https://blog.csdn.net/xiaoxufox/article/details/51353679)condition 是把当前线程从AQS同步等待队列中释放，放到condition的等待队列。并不waitStatus设置为-2。跟Object.await()相比一个锁可以有多个condition，这样唤醒的时候就可以有针对性，比如生产者消费者模式生产者和消费者就可以有不同的condition。   
    
    
            
    
    
