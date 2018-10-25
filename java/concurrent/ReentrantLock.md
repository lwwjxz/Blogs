1. 可重入每加锁一次state加一，每释放一次state减1直到减为0才算释放完其他线程才能获取。         
1. java.util.concurrent.locks.ReentrantLock.NonfairSync实现了tryAcquire。      
1. 公平锁和非公平锁的区别:
    公平锁在获取锁之前先判断队列中是否有等待的线程如果有则加入到等待队列的尾部，如没有则尝试获取锁。      
    非公平锁获取锁时先获取锁，获取失败才加入到等待队列的尾部。       
1. getHoldCount获取重入的次数。        
1. 
