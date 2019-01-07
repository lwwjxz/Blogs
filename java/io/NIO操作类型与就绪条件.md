1. [参考](https://blog.csdn.net/zhouhl_cn/article/details/6567877)
    1. [NIO就绪处理之OP_CONNECT](https://blog.csdn.net/zhouhl_cn/article/details/6568893)
    2. [NIO就绪处理之OP_ACCEPT](https://blog.csdn.net/zhouhl_cn/article/details/6582420)
    3. [NIO就绪处理之OP_WRITE](https://blog.csdn.net/zhouhl_cn/article/details/6582435)
        1. 写就绪相对有一点特殊，一般来说，你不应该注册写事件。写操作的就绪条件为底层缓冲区有空闲空间，而写缓冲区绝大部分时间都是有空闲空间的，所以当你注册写事件后，写操作一直是就绪的，选择处理线程全占用整个CPU资源。所以，只有当你确实有数据要写时再注册写操作，并在写完以后马上取消注册。
