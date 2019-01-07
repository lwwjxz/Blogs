These fields are declared here rather than in Heap-X-Buffer in order to reduce the number of virtual method invocations needed to access these values, which is especially costly when coding small buffers.
    //



1. io多个线程阻塞，NIO一个线程阻塞。   
1. [io实现socket](https://github.com/jasonGeng88/blog/blob/master/201708/java-socket.md) vs [NIO socket实现](https://github.com/jasonGeng88/blog/blob/master/201708/java-nio.md)    





参考: 
    不重要知道下:
        1. [Java NIO类库Selector机制解析（上）](https://blog.csdn.net/haoel/article/details/2224055)  
        1. [Java NIO类库Selector机制解析（下）](https://blog.csdn.net/haoel/article/details/2224069)   
        1. [Java NIO类库Selector机制解析（续）](https://blog.csdn.net/haoel/article/details/2379586)   
