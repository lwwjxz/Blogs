1. [参考](https://blog.csdn.net/justloveyou_/article/details/72783008)   
1. size方法返回的数量有可能不准确，因为它是所有的segment中的count相加得到的结果，而在加的过程中没有对count加锁。   
1. 由于value为Volatile不加锁多可能在还没写的时候读到，此时值肯定为null，而ConcurrentHashMap中不允许value为null所以此时需要加锁重读。      
1.concurrentHashMap中的各种操作(get ,put,remove等)不是同步的但是是可见的。       
