1. [ReferenceQueue的使用](https://www.cnblogs.com/dreamroute/p/5029899.html)      
    1. Reference关联了ReferenceQueue后对象被回收后会将包装的Reference对象放在ReferenceQueue中，可以自己起中一个线程处理这种情况，比如weakhashmap的实现。    
    1. weakhashmap的用法举例比如网络连接中EndPoint表示一个客户端链接，EndPoint中的属性socket中记录的连接信息如果连接锻炼，info表示客户端链接的信息如果把Socket当做key，info当多
