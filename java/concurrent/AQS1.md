
1. java.util.concurrent.locks.AbstractQueuedSynchronizer#acquire      
    为什么是忽略中断的？java.util.concurrent.locks.AbstractQueuedSynchronizer#acquireQueued明明会返回true。    
    try -> 入队 -> 死循环获取         
1. head是获取到锁的线程所在的node。      
1. setHead方法会把新的head的prev设置为null。        
1. 自旋逻辑：关键点park和unpark没有先后顺序所以就没有犹豫顺序不一样引发的问题了。           
   pred.waitStatus==Node.SIGNAL 等待pred唤醒。猜想waitStatus从pred.waitStatus变回其他值时会unpark队列中的下一个值，unpark在park前面也是可以的，所以的时候也有效。             
   pred.waitStatus==Node.CANCELLED 把pred移出队列。CANCELLED为最终状态所以不用担心真正去移出的时候状态有变调。    
   pred.waitStatus==0(初始化)或Node.PROPAGATE把pred.waitStatus设置为Node.SIGNAL不管是否失败则重新尝试获取锁。       
   只要不是Node.SIGNAL就继续遍历，
1. 第一个NODE入队后，node = head = tail       
1. 中断相应        
    `java.util.concurrent.locks.AbstractQueuedSynchronizer#acquire`获取同步器之前不响应中断。获取同步器后响应。        
    `java.util.concurrent.locks.AbstractQueuedSynchronizer#acquireInterruptibly`获取同步器的过程中响应中断。              
1. 共享锁第一个获取成功以后会把队列中后面的叫醒。      
    ```
    java.util.concurrent.locks.AbstractQueuedSynchronizer#doAcquireShared        
    java.util.concurrent.locks.AbstractQueuedSynchronizer#setHeadAndPropagate        
    java.util.concurrent.locks.AbstractQueuedSynchronizer#doReleaseShared       
    
    ```      
1. 所有acquire方法失败后都会调用final中的`java.util.concurrent.locks.AbstractQueuedSynchronizer#cancelAcquire`方法取消等待      
1. 只要不是Node.SIGNAL就继续遍历，        
1. condition     
    1. await会把线程对应的node拿出来放到等待队列。     
    1. 只有获取了锁才能调用await方法，在await方法中会尝试tryRelease，调用tryRelease的时候如果不是当前获取获取锁的线程会抛出异常。     
    1. await方法中会激活队列中的洗衣柜线程。        
    1. 被signal唤醒的线程会重新获取锁如果获取不到则加入等待队列。          
    1. 被uppark后从park的地方开始执行。     
   
