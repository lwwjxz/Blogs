1. 用处是做流量控制。
1. Semaphore用的是tryAcquireShared。因为自由state有可能不是1所以可以多个线程公用。              
