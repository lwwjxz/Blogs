[Doug Lea大神的ppt](http://gee.cs.oswego.edu/dl/cpjslides/nio.pdf)           
1. Basic Reactor Design 每个请求一个线程。    
1. Multi Threaded Dseigns 耗时请求交给线程池处理。跟Basic的比较少了生产和回收线程的资源消耗。      
1. Multiple Reactors 两个Reactors线程，一个(也可以是多个但是一般没必要)线程Acceptor。多个线程监听(注册)读写事件。    
```
Selector[] selectors; // also create threads 每个subReactor线程处理一个selector,所有的subReactor公用一个线程池
int next = 0;
class Acceptor { // ...
    public synchronized void run() { ...
        Socket connection = serverSocket.accept();
        // 把请求均衡的分配到不同的selector                           
        if (connection != null)
            new Handler(selectors[next], connection);
        if (++next == selectors.length) next = 0;               
     }
}
```
