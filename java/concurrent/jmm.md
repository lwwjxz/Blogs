1. 多线程的问题都是由重排序和内存可见性引起的。写出线程安全的多线程程序就是要正确的处理重排序和可见性问题。    
1. [深入理解Java内存模型（一）——基础](http://www.infoq.com/cn/articles/java-memory-model-1?utm_source=infoq&utm_campaign=user_page&utm_medium=link)      
    1. JMM定义了线程和主内存之间的抽象关系：线程之间的共享变量存储在主内存（main memory）中，每个线程都有一个私有的本地内存（local memory），
    本地内存中存储了共享变量的副本。       
    1. 编译器和处理器都会重排序
        1. 编译器优化的重排序。编译器在不改变单线程程序语义的前提下，可以重新安排语句的执行顺序。    
        1. 指令级并行的重排序。现代处理器采用了指令级并行技术（Instruction-Level Parallelism， ILP）
        来将多条指令重叠执行。如果不存在数据依赖性，处理器可以改变语句对应机器指令的执行顺序。   
        1. 内存系统的重排序。由于处理器使用缓存和读/写缓冲区，这使得加载和存储操作看上去可能是在乱序执行。    
        1. 编译器重排序可以通过代码控制，但是其他两种则是由jvm控制。     
    1. 共享内存和重排序都可能引起多线程的可见性问题。    
        1. 内存共享A线程写入数据，B线程如果不从主内存读的话就读取不到，这是由于共享内存。猜测:如果不是基本类型的话线程的本地内存只是保存的引用所以不会出现该情况。该猜测好像有点问题，即使不是基本类型也会有线程安全问题。此处不做深入分析。    
    1. 内存屏障类型load和stroe的四种组合。     
    1. happens-before:如果一个操作执行的结果需要对另一个操作可见，那么这两个操作之间必须存在happens-before关系。happens-before其实是一种关系。 代码之间存在happens-before关系。      
        程序顺序规则：一个线程中的每个操作，happens- before 于该线程中的任意后续(重排序后的顺序)操作。    
        监视器锁规则：对一个监视器锁的解锁，happens- before 于随后对这个监视器锁的加锁。    
        volatile变量规则：对一个volatile域的写，happens- before 于任意后续对这个volatile域的读。     
        传递性：如果A happens- before B，且B happens- before C，那么A happens- before C。      
1. [深入理解Java内存模型（二）——重排序](http://www.infoq.com/cn/articles/java-memory-model-2?utm_source=infoq&utm_campaign=user_page&utm_medium=link)       
    1. as-if-serial语义:不管怎么重排序（编译器和处理器为了提高并行度），
    （单线程）程序的执行结果不能被改变。编译器，runtime 和处理器都必须遵守as-if-serial语义。     
1. [深入理解Java内存模型（三）——顺序一致性](http://www.infoq.com/cn/articles/java-memory-model-3?utm_source=infoq&utm_campaign=user_page&utm_medium=link)       
    1. 深入理解Java内存模型（三）——顺序一致性(所有线程看到的执行顺序都是一致的。)顺序一致性举多线程中重排序的例子说明。        
        1. 在一个线程中写一个变量.     
        1. 在另一个线程读同一个变量.      
        1. 而且写和读没有通过同步来排序.       
        1. 如果一个多线程程序能正确同步，这个程序将是一个没有数据竞争的程序。出现数据竞争有可能得到错误的结果    
    1. JMM不保证顺序一致性，需要些代码保证。JMM只能保证最小安全性      
1. [深入理解Java内存模型（四）——volatile](http://www.infoq.com/cn/articles/java-memory-model-4?utm_source=infoq&utm_campaign=user_page&utm_medium=link)       
    1. 禁止重排序和保证内存可见性。     
    1. 可以当做普通的get，set方法加了synchronized。      
1. [深入理解Java内存模型（五）——锁](http://www.infoq.com/cn/articles/java-memory-model-5?utm_source=infoq&utm_campaign=user_page&utm_medium=link)         
    1. lock,由于加锁和释放锁都操作了volitale保证了内存可见并禁止了重排序。     
1. [深入理解Java内存模型（六）——final](http://www.infoq.com/cn/articles/java-memory-model-6?utm_source=infoq&utm_campaign=user_page&utm_medium=link)        
    1. 在构造函数内对一个final域的写入，与随后把这个被构造对象的引用赋值给一个引用变量，这两个操作之间不能重排序。    
    1. 初次读一个包含final域的对象的引用，与随后初次读这个final域，这两个操作之间不能重排序。编译器不可能出现这种重排序，这种主要是针对部分架构的CPU(不做深入研究)。    
    1. 构造函数中final引用对象成员变量写不能排序到构造函数外，推测成员变量的成员变量的写也不能重排序到构造函数外，这样用起来才简单合理。     
1. [双重检查锁定与延迟初始化](http://www.infoq.com/cn/articles/double-checked-locking-with-delay-initialization?utm_source=infoq&utm_campaign=user_page&utm_medium=link)       
    1. 基于volatile的双重检查锁定的解决方案因为instance = new Instance()是分三步的，如果不用volatile这三步直接可以重排序当另一个线程执行外层的if (instance == null) 因为此线程没有获取锁所以有可能instance已经被分配内存(!=null)但是没有被实例化。      


