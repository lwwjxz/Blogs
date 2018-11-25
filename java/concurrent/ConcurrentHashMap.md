1. [参考](https://blog.csdn.net/justloveyou_/article/details/72783008)   
1. size方法返回的数量有可能不准确，因为它是所有的segment中的count相加得到的结果，而在加的过程中没有对count加锁。 
2. 读是不加锁的，因为HashEntry中的值除了value是volatile剩下的都是final，volatile保证了可见性，而 concurrentHashMap的value不支持null所以如果获取的值为null则加锁重即可，这样保证了大部分读的情况下不用加锁。 
1.concurrentHashMap中的各种操作(get ,put,remove等)不是同步的但是是可见的。       
