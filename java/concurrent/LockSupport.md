1. 只有获取对象A的锁才能调用A的wait方法。notify也是一样的。      
1. sleep也不需要获取锁，但是如果获取到锁的情况下调用sleep方法后不会释放锁。而wait会。        
1. JDK1.6后synchronized性能得到很多的优化所有wait跟LockSupport相比性能也不差。      
1. 若当前线程有许可，立即返回。否则阻塞，直到以下条件触发[参考](https://blog.csdn.net/guozebo/article/details/50492068)     
      1. 其他线程调用了LockSupport.unpark()来对该线程发放许可
      1. 其他线程调用了该线程的interrupt()方法进行中断，注意是不会抛出InterruptedException
      1. 没有理由（意思是该方法底层实现无法完全保证线程一直处于阻塞，因此建议在循环块调用该方法）很容易复现见`com.lww.test.thread.LockSupportTest`     
  
1. 一个线程只能调用一次park方法，因为调用后随即阻塞。blocker就是阻塞的起一个名字，jstack方便排查。        
