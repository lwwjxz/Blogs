1. 多个线程一起做完某件事后才能做下面的事情。 等待大家都主播好后一起执行。            
1. 实现的基础是ReentrantLock和Condition和一个count(需要相互等待的线程数量)，每个线程调用await方法后count都-1然后wait在Condition上，当count变为
0收调用Condition.singalAll通知等待的线程开始执行。并把count设置为初始化的值所以可以再次使用。      
