1. ThreadLocal主要是用于线程间的数据隔离，而锁是用于线程间的数据共享。         
1. 想象你在开发一个电子商务应用，你需要为每一个控制器处理的顾客请求，生成一个唯一的事务ID，同时将其传到管理器或DAO的业务方法中，以便记录日志。一种方案是将事务ID作为一个参数，传到所有的业务方法中。但这并不是一个好的方案，它会使代码变得冗余。你可以使用ThreadLocal类型的变量解决这个问题。
2. ThreadLocal 提供了线程本地的实例。它与普通变量的区别在于，每个使用该变量的线程都会初始化一个完全独立的实例副本。ThreadLocal 变量通常被private static修饰，然后被静态的方法操作所以任何地方都能操作。当一个线程结束时，它所使用的所有 ThreadLocal 相对的实例副本都可被回收。
3. 总的来说，ThreadLocal 适用于每个线程需要自己独立的实例且该实例需要在多个方法中被使用，也即变量在线程间隔离而在方法或类间共享的场景。
4. [参考](https://www.jianshu.com/p/98b68c97df9b)   
    1. 每个线程中都已一个ThreadLocalMap来报错本地变量在线程中第一次调用任意ThreadLocal实例的set(java.lang.ThreadLocal#set)方法的时候生成。key为ThreadLocal实例本身。
    2. 在多个线程中作为key的ThreadLocal变量可以是统一个对象，同一个key在不同线程的ThreadLocalMap取出来的value不同。
    2. ThreadLocal实例用完一定要remove否则会造成内存泄漏或者如果线程是线程池中可以多次复用的线程则有可能对下次


1. Thread中有一个ThreadLocalMap变量，ThreadLocalMap中是存的是Entry的数组，Entry对象中存的是ThreadLocal实例和对应的值。   
1. Thread中有一个ThreadLocalMap变量，ThreadLocalMap存储的是已ThreadLocal的实例为key，要存储的变量为value的对象。       
1. 几乎所有的框架线程都是放在线程池复用的，所有一单该线程局部变量用完后需要一定要remove方法清除掉如果不清楚掉如果ThreadLocal的实例为静态变量或者多个线程共享的变量则前面使用
的值可能会对后面使用造成影响，特别是ThreadLocal放的是集合每次都对集合进行add操作还有可能内存溢出，如果非静态且局部变量每次生成一个对象如果不清理则可能内存溢出(源码中是弱引用肯能不用remove也没关系但是自己没有测试所以还是remove比较保险)。      
1. 对于多线程共享的ThreadLocal的在每个线程的java.lang.Thread#threadLocals都有被引用。在一个线程的java.lang.Thread#threadLocals中存储的是该线程
相关的所有ThreadLocal，并且ThreadLocal的threadLocalHashCode为key，key对应的对象为对饮的value。        
1. 所有如果有对象需要在同一个线程的所有执行路径都要用且不想当参数传来传去就可以定义为静态的ThreadLocal。        

