1. 在内核中，为每个 Socket 维护两个队列。一个是已经建立了连接的队列，这时候连接三次握手已经完毕，处于 established 状态；一个是还没有完全建立连接的队列，这个时候三次握手还没完成，处于 syn_rcvd 的状态。     
1. 每一个连接对应一个socket文件描述符。    
1. io多了复用（解决C10k问题，该问主要是操作系统基本不能创建10k以上个线程或进程）：1. 一个线程管理多个socket。2. epoll 时间通知的方式(解决c10k问题的利器，理论上限是文件描述符的上线)。        
