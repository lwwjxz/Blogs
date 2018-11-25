1. 内存管理
    1. 内存区域及作用，可能发生的异常，相关参数。
        1. 运行时数据区可以分为堆、方法区、虚拟机栈、本地方法栈、程序计数器等五中。
            1. 程序计数器:当前线程所执行的字节码行号指示器。不会抛出异常
            1. 虚拟机栈:存储方法执行过程中的局部变量，操作数栈，动态链接，方法出口信息等。默认大小JDK版本不同而不同，设置参数-Xss128k。一般不设置。当申请不到内存抛出OOM，当栈深度过大时抛出StackOverflowError。最大深度也用jvm参数设置。
            1. 本地方法栈与虚拟栈非常相似，只不过它是为本地方法服务的。HotSpot虚拟机不区分本地方法栈和虚拟方法栈。
            2. java堆内存:存放实例对象，几乎所有对象实例都在堆内存。内存不够是抛出OOM。参数:-server防止堆内存动态调整影响性能，`-Xms<heap size>[g|m|k] -Xmx<heap size>[g|m|k]` -Xms和-Xmx一致。
            3. 方法区:又名非堆区，永久区。主要储存类信息、常量、静态变量等。JDK1.8之后HotSpot去掉到方法区，类信息和常量池分别移到MetaSpace和堆中。
        2. 可分为线程共享的区域和线程隔离的区域
            1. 线程共享:堆，MetaSpace其他为线程隔离的。
    3. 垃圾收集算法和垃圾收集。
        1. 引用计数法和可达性分析法。ROOTGC:线程栈中的局部变量，MetaSpace中的类静态属性引用的对象，方法区中常量引用的对象，本地方法栈中JNI(即Native方法)引用的对象。
        2. 对象可以在finalize()方法中自救但是每个对象只能自救一次。
        3. 方法区也可回收，而且也有必要回收特别是大量使用反射、动态代理、CGLib等字节码框等。
        4. 垃圾收集算法
            1. 标记清理算法:碎片太多。
            2. 复制算法:Eden和Survivor比例设置为8:1解决内存浪费的问题.如果确实另一个survivor取确实装不下可有由老年代来担保。老年代没有担保所以不能用复制算法。
            3. 标记整理:解决了标记清理法的碎片问题。
            4. 分代算法:年轻代用复制算法，老年代用标记整理或标记清理算法。因为老年代可以为年轻代做担保但是老年代找不到担保。
        1. 垃圾收集引起的stop-the-word时间越短越好。
        2. 垃圾收集器:所有的收集器都会stw，G1和ZGC没研究过
            1. Serial：年轻代单线程，适合单核cpu
            1. ParNew: 年轻代收集器，Serial的多线程版本
            1. Parallel Scavenge: 年轻代，跟ParNew的不同:目的是获得最大吞吐量(定时任务)，而ParNew是获得最小停顿时间，不能与CMS配合使用。
            1. Serial Old：老年代单线程，适合单核cpu。
            1. Parallel Old:Parallel Scavenge的老年代。
            1. CMS:concurrent mark sweep,好处是几乎没有stw，用户体验比较好。
            1. G1:年轻代和年老代,把内存分成很多个区域，停顿时间更短。
            1. ZGC:java11中新加的目前处于测试阶段，可以管理TB级内存且停顿时间可以保证在10ms以内。
        1. [GC 日志:](https://blog.csdn.net/renfufei/article/details/49230943)
            1. Allocation Failure – 引起垃圾回收的原因. 本次GC是因为年轻代中没有任何合适的区域能够存放需要分配的数据结构而触发的.
            2. 垃圾回收的时间：有可能是几点几分也有可能是从应用启动开始后经过了多少秒。
    1. 内存分配策略:
        1. 优先分配到eden,收集结果直接放到suvivor。每收集一次年龄加1，到了一定的年龄后移到老年代。
        2. 大对象知己进入老年代。
    4. 常用工具:
        1. jps 最常用: jps -lv
        2. jstat：虚拟机信息监视工具。
            1. class：类的加载卸载信息。
            1. gc：垃圾回收相关。
            2. compiler: JIT编译过的方法,耗时等。
            3. printcomplilation：已经被JIT编译的方法。
        1. jinfo:java配置信息工具
            1. jps -v 只能查询显式指定的参数，jinfo可以显示默认的信息
            2. jinfo -sysprops打印System.getProperties()的内容
            3. jinfo -flag运行过程中改变参数
        1. jmap:java内存映射工具
            1. linux上kill -3 pid 也会生成dump
            2. -heap显示堆详细信息
            3. -histo显示堆中的统计信息
            1. 风险提示   
                1. 最主要的危险操作是下面这三种： 
                1. jmap -dump 这个命令执行，JVM会将整个heap的信息dump写入到一个文件，heap如果比较大的话，就会导致这个过程比较耗时，并且执行的过程中为了保证dump的信息是可靠的，所以会暂停应用。
                2. jmap -permstat 这个命令执行，JVM会去统计perm区的状况，这整个过程也会比较的耗时，并且同样也会暂停应用。
                3. jmap -histo:live 这个命令执行，JVM会先触发gc，然后再统计信息。上面的这三个操作都将对应用的执行产生影响，所以建议如果不是很有必要的话，不要去执行。
                1. 另外，在排查问题的时候，对于保留现场信息的操作，可以用gcore [pid]直接保留，这个的执行速度会比jmap -dump快不少，之后可以再用jmap/jstack等从core dump文件里提取相应的信息，不过这个操作建议大家先测试下，貌似在有些jdk版本上不work。 
                >用gcore或gdb创建了核心转储，那么你需要将其转换为一个称为HPROF文件的东西。这些可以由VisualVM，Netbeans或Eclipse的内存分析器工具(以前称为SAP内存分析器)使用。我会推荐Eclipse MAT。要转换文件，请使用命令行工具jmap。    
                `jmap -dump:format=b,file=dump.hprof /usr/bin/java core.1234`   
                dump.hprof是要创建的hprof文件的名称   
                / usr / bin / java是生成核心转储的java二进制版本的路径   
                core.1234是您的常规核心文件。 一般1234就是PID。   
                1. 示例`jmap -dump:format=b,file=/xxxx/xxxx/xxx/filename 56466` 其中file参数指定生成文件的路径，如存在则不生成。 
        1. jstack:生成线程快照
            1. -F 没响应时强制输出堆栈。  
            2. -l 显示有关锁的信息。   
            3. -m 显示本地方法的堆栈信息。   
            4. 死锁线程信息也会导出。   
        1. jconsole：相当于jstat,jstack等。
            1. 能检测出死锁。
        1. visualVM：all-in-one
            1. 有一些特许远程不支持。
        1. [greys](https://github.com/oldmanpushcart/greys-anatomy) 在线问题诊断工具，比visualVM的BTrace好用多了，
        可以在线修改，比如增加日志。            
    1. 注意事项。
        1. 堆内存不是越大越好，也得垃圾收集需要的时间也就越长，停顿就越长。
2. 类加载机制
    1. 虚拟机
        1. jvm不和包括java在内的任何语言绑定，它只与class文件有关联。   
    1. 类加载机制
        1. 对于任意一个类，都需要有加载器和类本身确定在java虚拟机中的唯一性。
        2. [isAssignableFrom,isInstance,instanceof。左边是右边的子类，子接口也返回true。](https://stackoverflow.com/questions/3949260/java-class-isinstance-vs-class-isassignablefrom)
        3. 类加载可以分为两类一类是Bootstrap ClassLoader,一类是其他加载器。
            1. Bootstrap ClassLoader是由C++实现的是虚拟机的一部分，其他的都是由java语言实现并且全都继承自java.lang.ClassLoader的不属于虚拟机。
        1. 类加载器也可以细分为四类
            1. Bootstrap ClassLoader 默认只加载<JAVA_HOME>/lib/rt.jar中的包。也可以用
            -Xbootclasspath参数指定路径。
            1. Extension ClassLoader 由sun.misc.Launcher.ExtClassLoader实现的负责加载<JAVA_HOME>\lib\ext或者别java.ext.dirs系统变量指定路径中的所有类库。
            2. Application ClassLoader 应用程序类加载器，负责加载用户类路径ClassPath上指定的所有的类。
            3. 还可以子定义类加载器。
            1. 双亲委派模式中只要上级能加载到就用上级的。自己手动写一个与rt.jar同包同名的类用于不会被加载。
            2. 双亲委派的破坏
                1. 为了兼容jdk1.0期间的类加载器。
                2. 基础类调用用户代码JNDI，SPI(SPI)
                    1. 因为new对象的时候默认的类加载是new所在的类的类加载器，而该类的类加载器对应的classpath没有要加载的类，所以测试就需要调用其他的类加载器。
                1. 热加载相关的破坏。
            1. tomcat 为什么需要自定义类加载器。
                1. 不同的应用要用不同的代码需要相互隔离。
                2. 不同应用的有需要共享的类。
                3. jsp需要热部署。
3. 编译与代码优化
    1. 泛型实际上是语法糖，javac会把代码转化为Object然后在强制转换。
4. 并发
    1. java并发的复杂度都是由于不同的线程之间共享内存和指令重排序引起的。因为线程要修改内存中的变量必须先把变量从共享内存
    中读取到本地内存再此期间其他线程有可能修改。
        1. 重排序就是指改变程序的执行顺序，重排序在单线程中要保证执行结果跟没有发生重排序以前一样。
        2. 顺序一致性模型。
        3. volatile相当于加了锁的get,set方法。volatile可以保证内存可见性，乐观锁的内存可见性就是
        由volatile保证的。
        4. synchronized保证了内存可见性和原子性。原子性是指一个获得锁的synchronized的代码块不会被获得同一个锁的其他synchronized代码块打断。
        5. final禁止构造函数中对final对象的赋值和随后把这个被构造对象的引用赋值给一个引用变量重排序。
        2. java虚拟机内存模型只是一种等效的规范。即在如果逻辑在规范中没问题在实现中就不会有问题。
        



