
1. 线程的基本概念
    1. 线程的状态:见枚举类java.lang.Thread.State。
        1. new ,runable,blocked,waiting,timed_waiting,terminated.其中
        runable状态表示的是等待CPU分配实践的状态，其他状态注释说的都很清楚了。
    1. Interrupt
        1. 调用start()方法前调用Interrupt()对线程没有任何影响跟没调一样。
        2. start()之后调用Interrupt()然后再sleep也会抛出异常，猜测异常只跟interrupt状态有关。
        1. wait,sleep抛出InterruptedException异常，并且节省线程。
        2. 线程如果因为调用park而阻塞的话，能够响应中断请求(中断状态被设置成true)并中断park继续执行，但是不会抛出InterruptedException。
        且只要Interrupt状态为true，park就是无效的。
        3. isInterrupted是Thread线程对象的方法，返回线程的中断状态对不影响中断状态，且对线程的状态不造成任何影响。
        4. interrupted静态方法，返回当前线程的中断状态并将其设置为false，如果线程对中断状态有响应则有可能对当前线程有影响，因为当前线程
        有可能已经读到中断状态为true开始处理中断逻辑了。
        1. [interrupted和isInterrupted的区别](https://stackoverflow.com/questions/1904072/java-difference-in-usage-between-thread-interrupted-and-thread-isinterrupted)
    1. 因为多线程重量级锁需要来回切换上下文所以多线程效率不一定高。
        1. 无锁并发:用一些办法避免使用锁竞争，比如把10亿个数加起来，
        可是把这10亿个数分为10组分别计算最好再把10个结果加起来。
        2. CAS算法，减少锁的使用。
        3. 避免创建不必要的线程。
        4. [协程](https://segmentfault.com/a/1190000005342905)
            1. 在单线程里实现多任务调度，并在单线程里维持多个任务间的切换。
            2. 协程间的协调不会引发用户态和内核态之间的转化，比较节省开销。
2. synchronized相关知识,见synchronized.md。
    
3. JUC工具包
    1. 锁相关
        1. lock跟synchronized相比需要显示的获取锁和释放锁但是更灵活了，比如
            1. lock可以先获取A锁->获取B锁->释放A锁->释放B锁。而synchronized只能
            先获取A锁->获取B锁->释放B锁->释放A锁，多把锁的情况更是如此。
            2. 尝试非阻塞地获取锁，当前线程尝试获取锁如果这一刻没有被其他线程获取
            则获取锁，否则获取失败，而synchronized只能阻塞。
            3. 能被中断的获取锁？
            4. 
    1. AQS:是用来构建锁和其他同步组件的基础框架。
        1. AQS的实现逻辑就是先尝试获取资源获取不到则排队等候，获取资源和释放资源的规则都由子类来决定，排队优先级也是由子类来决定的(比如:公平锁和非公平锁),还可以等待在条件队列上。
        1. 锁是面向使用者，而AQS是面向锁的实现者，所以被推荐为自定义同步组件的
        静态内部类。
        1. AQS是基于模板方法模式的，需要继承者继承并重写指定的方法。
        2. state字段是一个在不同的场景下有不同意义的协调多线程关系的字段。
            1. 在CountDownLatch中state的值表示正在等待线程数量。
            2. ReentrantLock中表示获取锁的次数。
        1. AQS的模板方法:
            1. acquire(int arg)独占式获取同步状态，如果当前线程没有获取到同步状态被放在队列里不会相应终止状态，排队的过程中被unpark后不会考虑中断状态。
            2. acquireInterruptibly(int arg)，独占式获取同步状态，如果当前线程没有获取到同步状态被放在队列里会响应终止状态，排队的过程中被unpark后发现为中断状态则抛出InterruptedException。
            3. tryAcquireNanos(int arg, long nanosTimeout)，会响应中断。
            4. acquireShared(int arg)共享式的获取状态跟acquire(int arg)主要区别就是在队列排队的时候获取状态的方法。
            5. acquireSharedInterruptibly(int arg). 同一个时刻可以有多个线程获取到状态，队列中排队的node中唤醒的方式也不一样，不再是只唤醒第一跟node中的线程。
            6. release(int arg),释放同步状态并唤醒队列中第一个节点中等待的线程。
            7. releaseShared(int arg)释放共享的同步状态。
        1. AQS需要子类实现的方法:
            1. tryAcquire(int arg)
            2. tryAcquireShared(int arg)
            3. tryRelease(int arg)
            4. tryReleaseShared(int arg)
            5. isHeldExclusively获取锁的是不是当前线程
        1. Condition
            1. 调用await和singal,singalAll方法的时候都需要获取对应的lock,对应lock的意思是生成contition对象的lock。
            2. await有对饮的超时，不响应中断，时间限制等。
    1. 重入锁:ReentrantLock
        1. 重复获取所示state+1,释放一次就-1；
        2. 分为公平锁和非公平锁，公平锁的意思是现申请的线程现货区锁
    1. 读写锁:ReentrantReadWriteLock
        1. 非公平有可能饿死写锁。
        2. 锁降级:获取写锁->获取读锁->释放写锁。
            1. 锁降级能保证写锁释放后在没有其他写操作的的情况下获取到读锁。
            2. [JDK读写锁ReadWriteLock的升级和降级问题](http://www.voidcn.com/article/p-mkzkjouu-db.html)
    2. 并发集合
        1. 普通的集合都是线程不安全的如果两个线程调用list的add方法有可能最后只有一个成功，hashMap也有个同样的问题。
        1. ConcurrentHashmap:分段锁，读的时候不加锁.
        2. CopyOnWriteXXX。
    1. 并发工具类
        2. CountDownLatch。
        3. CyclicBarrier。
        4. Exchanger
        5. Semaphore
    1. ThreadLocal
        见ThreadLocal.md
    3. 线程池
        1. 源码:todo。
        1. 优点：
            1. 降低创建/销毁线程的资源消耗。
            2. 提高次响应速度。
            3. 提高线程的可管理性。如果每个请求都创建一个线程的话当并发量大了话将会把资源耗尽，如果使用线程池的可以通过各种策略来应对。
        4. 主要处理流程。
            1. 需要注意的是只要核心线程池没满，当有新的任务提交时都会创建线程，不关心当前的线程是否空闲。
        1. 创建线程池的参数。
            1. corePoolSize 核心线程数
            2. maximumPoolSize 最大线程数
            3. keepAliveTime 大于核心线程数时，线程最大的空闲时间
            4. BlockingQueue 阻塞队列，需要注意的是[synchronousQueue](https://blog.csdn.net/yanyan19880509/article/details/52562039)没有容量的的队列，可以用在需要生产者和消费者速度差不的地方。                
            5. ThreadFactory 线程工程可以自定义，guava中用个实现方案挺方便的。
            6. RejectedExecutionHandler拒绝策略。
        1. 提交任务。
            1. excute()不返回结果。
            2. submit()返回结果。 
        1. [线程池的状态](https://blog.csdn.net/L_kanglin/article/details/57411851)。
            1. Running，shutdown,stop,tidying,terminated

        1. 线程池的关闭。
            1. shutdown()：不会立即终止线程池，而是要等所有任务缓存队列中的任务都执行完后才终止，但再也不会接受新的任务      
            1. shutdownNow()：立即终止线程池，并尝试打断正在执行的任务，并且清空任务缓存队列，返回尚未执行的任务  
        1. 线程池的监控。
            1. taskCount，completedTaskCount等
            3. 重写线程池的beforeExcute，afterExcute和terminated等方法可以在任务执行前，执行后和线程池关闭前执行一些代码来进行监控。
        1. Runnable、Future、RunnableFuture、FutureTask、Callable。 
            1. Runnable提交给线程的任务实例接口。
            2. Future是任务提交个线程池后返回值的获取接口。
            3. RunnableFuture是Runnable和Future的组合接口。
            4. FutureTask是RunnableFuture的实现，FutureTask中的java.util.concurrent.FutureTask#run方法实现了返回值，因为FutureTask其实是父线程和子线程共享的所以父线程可以在FutureTask中获得子线程执行的结果。
            5. Callable是FutureTask的成员变量，主要是描述需要放回的内容
1. 分布式锁
    1. 实现分布式锁的时候需要考虑以下下几个问题。
        1. 需不需要重入
        2. 获取锁失败时是直接返回还是阻塞。
        3. 获取锁和释放锁的性能要好。
        4. 依赖的第三方要高可用，比如redis,zk等。
        5. 考虑解锁操作失败该怎么处理。
        6. 是否需要共享锁。
    1. 各种实现方案的缺点
        1. 数据库:性能不好，要实现功能完善锁比较麻烦。优点是比较容易理解，因为相对于redis和zk来说大家最熟悉的还是数据库。
        2. redis等缓存:性能好并且实现起来比较方便。缺点:阻塞锁不太好实现，超时时间不好估计。
            1. 开源的redis客户端redisson实现超时的方式是： 先上锁，默认过期时间30秒，如果处理完了，走正常逻辑。 他对一个值加锁之后，会在自身维护一个加锁池的队列，每过10秒去重新设置一下过期时间，这样，一个锁即使对应的进程挂掉，也就维持30秒的时间，如果没有挂，并且30秒不够用了，他的内部队列会不断的更新这个过期时间为30秒，保证不会出现锁饥饿的问题。我之前这一块的时候也是没有解决锁饥饿的问题，后来发现redisson是这样做的。redission实现了几个JUC工具包的分布式版本。
            2. redission的源码值得抽时间读一下。
        3. zk
            1. 使用Zookeeper可以有效的解决锁无法释放的问题，因为在创建锁的时候，客户端会在ZK中创建一个临时节点，一旦客户端获取到锁之后突然挂掉（Session连接断开），那么这个临时节点就会自动删除掉。其他客户端就可以再次获得锁。
            2. 使用Zookeeper可以实现阻塞的锁，客户端可以通过在ZK中创建顺序节点，并且在节点上绑定监听器，一旦节点有变化，Zookeeper会通知客户端，客户端可以检查自己创建的节点是不是当前所有节点中序号最小的，如果是，那么自己就获取到锁，便可以执行业务逻辑了。
            3. 使用Zookeeper也可以有效的解决不可重入的问题，客户端在创建节点的时候，把当前客户端的主机信息和线程信息直接写入到节点中，下次想要获取锁的时候和当前最小的节点中的数据比对一下就可以了。如果和自己的信息一样，那么自己直接获取到锁，如果不一样就再创建一个临时的顺序节点，参与排队。
            4. 跟使用缓存相比性能不太好。
            5. 开源框架Curator。
        4. 综上所述推荐用redisson.
4. java并发编程实践。
    1. 线上问题定位
        1. cpu使用率过高。
            1. `top -H -p <pid>` 查看CPU使用率最高的线程。
                1. 一直是100%。
                2. 一直在TOP10。
                3. CPU利用率高的几个线程在不停的变化。
            1. 可能的原因：
                1. 死循环。
                2. 频繁的GC。
            1. jstack 结果中的nid表示线程，不过是16位的要用。需要用printf命令转为10位进制跟top -H的结果比较。  
            2. 查看连接数，查看网络流量，查看CPU的使用率，查看内存等参考《java并发编程的技术》
5. java编程中的一些好的实践《并发编程实战》。
6. 


