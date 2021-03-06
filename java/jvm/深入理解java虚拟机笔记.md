1. JVM运行时数据区域=方法区+堆+栈+本地方法栈+程序计数器+···。  
1. 直接内存不属于虚拟机管理的内存但也属于jvm进程所使用的内存。     
1. 程序计数器:线程执行的字节码的行号指示器。每个线程一个计数器。该区域是jvm规范中没有规定任何OutOfMemoryError的情况。    
1. 虚拟机栈:虚拟机栈是线程私有的，声明周期与线程相同。每个方法在执行的同时都会创建一个栈帧。    
1. 本地方法栈:跟虚拟机栈的不同是本地方法栈服务于native方法。    
1. 堆是被线程共享的。    
1. 方法区(Method Area 别名 Non-Heap): 被线程共享的，用于存储已经被jvm加载的类信息、常量、静态变量、即时编译器编译(JIT)的代码等数据。
2. [Metaspace](https://blog.csdn.net/sczyh22/article/details/46662279)
    PermGen 最终被移除，方法区移至 Metaspace，字符串常量移至 Java Heap  最直接的表现就是java.lang.OutOfMemoryError: PermGen 空间问题将不复存在，因为默认的类的元数据分配只受本地内存大小的限制，也就是说本地内存剩余多少，理论上Metaspace就可以有多大（貌似容量还与操作系统的虚拟内存有关？这里不太清楚），这解决了空间不足的问题。   
1. 运行时常量池: 方法区的一部分用于存放编译期生成的`(不太理解什么是编译期生成)`各种字面量和符号引用。并不是只有编译期才能产生常量，运行期间也可以将新
的常量放入池中，这种特性被开发人员利用的比较多的是String的intern()方法`(不太懂)`。
1. 直接内存:直接内存并不是虚拟机运行时数据区域的一部分，也不是java虚拟机规范中定义的内存区域。但是这部分内存也被
频繁的使用，而且也可能导致OOM。NIO的中的DirectByteBuffer对象就指向的是直接内存。避免了在java堆和Native堆中的
来回复制数据。     
1. 永久带是hotspot中对方法区的实现。-Xmx 8G中的8G不包含永久带。永生代是hotspot中的一个概念，其他jvm实现未必有，例如jrockit就没这东西。java8之前，hotspot使用在内存中划分出一块区域来存储类的元信息、类变量以及内部字符串（interned string）等内容，称之为永生代，把它作为方法区来使用。[JEP122][2]提议取消永生代，方法区作为概念上的区域仍然存在。原先永生代中类的元信息会被放入本地内存（元数据区，metaspace），将类的静态变量和内部字符串放入到java堆中。     
1. System.gc()能手动回收垃圾且为fullgc。    
2. When a Garbage Collector gets called, it starts iterating over all elements in the heap. GC stores reference type objects in a special queue.
1. GC Roots 分为下面几种:
    1. 虚拟机栈中引用的对象。   
    1. 方法区中静态属性引用的对象。   
    1. 方法区中常量引用的对象。   
    1. 本地方法栈中引用的对象。   
1. 不可达ROOT GC后还有一次不被收集的机会就是 finalize方法还可以重新拯救自己，但是不保证finalize方法一定会被执行完，
引用如果finalize方法发生阻塞或者死循环可能导致整个系统崩溃。所以要用钩子。    
1. 回收方法区:     
    1. 无用的类    
        1. 该类的所有实例已经被回收。   
        1. 加载该类的ClassLoader已经被回收。    
        1. 该类对应的java.lang.Class对象没有被任何地方引用。    
    1. 不再被引用的常量。判断方法跟堆中的变量一样。    
    1. 在大量使用反射、动态代理、CGlib等ByteCode框架、动态生成JSP以及OSGI这类频繁自定义ClassLoader的
    场景都需要虚拟机具备类卸载的功能，以保证永久带不会溢出。    
    1. 参数:
        1. 虚拟机默认是会回收方法区的如果不想会后则加参数-Xnoclassgc
        1. 可以用 -verbose:class 以及 -XX:+TraceClassLoading -XX:+TraceClassUnLoading查看
        类的加载和卸载信息,-XX:+TraceClassUnLoading只有在FastDebug版的虚拟机支持。    
1. 复制算法当Survivor不够用时会分配到老年代。    
1. 标记整理适合老年代因为如果用复制法的话没有担保万一survivor不够用就麻烦了。   
1. 枚举跟节点:枚举根节点需要stop the world 所以停顿时间越短越好最优解是用准确GC代替保守GC和办保守GC。    
1. 只有达到安全点后才能进行GC。    
1. 垃圾收集器的种类。[参考](https://crowhawk.github.io/2017/08/15/jvm_3/)      
    1. Serial收集器单线程停顿时间长且是最古老的收集器，在client模式或者单核下。Serial收集年轻带，    该收集器使用复制算法。   
    1. SerialOld收集老年代。该收集器使用标记整理算法。    
    1. ParNew  Serial的多线程版本适用于年轻带。是年轻代收集器中唯一能和CMS配合工作的。     该收集器使用复制算法             
    1. Parallel Scavenge年轻代收集器，关注吞吐量的垃圾收集器吞吐量越高cpu用于垃圾收集的时间越少。而CMS等手机器是尽快能stop the world的时间。所以要与用户交互的应用最好不选用该收集器。    该收集器使用复制算法。     
    1. CMS标记整理算法:Concurrent Mark Sweep。     
    1. G1
1. 并行（Parallel）：指多条垃圾收集线程并行工作，但此时用户线程仍然处于等待状态。
并发（Concurrent）：指用户线程与垃圾收集线程同时执行（但不一定是并行的，可能会交替执行），用户程序在继续运行。而垃圾收集程序运行在另一个CPU上。     
1. 理解GC日志    
    1. 最前面的数组表示GC发生的时间：从虚拟机启动以来经过的秒数。    
    1. `GC` 和 `Full GC`是证明这次收集的停顿类型不是用来区分新生代还是老年代的（正常情况下一天或者十几个小时一次full GC）。    
    1. `DefNew Tenured `等是表示GC发生的区域，区域名称更GC收集器相关。 2323k->123k(5000k)`回收前容量->回收后容量(该区域总容量)`    
    1. 方括号    
    1. 
1. [并行并发的区别](https://www.zhihu.com/question/33515481)          
1. 大对象直接进入老年代，最好避免朝生夕死的大对象。     
1. 年龄大于MaxTenuringThreshould直接进入老年代，空间中年龄相同的对象大于或等于survivor容量的一般则年龄大于或等于该年龄的对象就可以直接进入老年代
不必大于MaxTenuringThreshould。     
1. survivor的容量不足以接受一次young gc的结果时会直接进入老年代称为空间分配担保。    
1. jstat [结果解释](https://blog.csdn.net/maosijunzi/article/details/46049117)      
1. jmap    
    1. 导出整个JVM 中内存信息`jmap -dump:format=b,file=文件名 [pid]`       
    1. 查看整个JVM内存状态 `jmap -heap [pid]`要注意的是在使用CMS GC 情况下，jmap -heap的执行有可能会导致JAVA 进程挂起      
1. VisualVM   
    1. 生成堆dump     
    1. 分析程序性能     
    1. profiler页中可以看方法的耗时点击CPU可以查看方法的耗时，点击内存则可查看每个方法关联的对象以及这些对象所占的内存。     
    1. Btrace通过HotSwap(热替换)技术修改。     
1. 开启JMX对性能几乎没什么影响。    
1. Runtime.getRuntime().exec()非常耗性能最好不用。    
1. 对应程序员而言类加载阶段中获取二进制流的动作是最可控的。     
1. java中数组类本身不通过类加载器创建，类的原始才会通过类加载器创建。     
1. 类加载器:        
    1. BootStrap 加载JAVA_HOME/lib目录中的类，或者-Xbootclasspath中的类（仅按名称加载？),
        ```
        sun.boot.class.path = /usr/java/jdk1.8.0_121/jre/lib/resources.jar:/usr/java/jdk1.8.0_121/jre/lib/rt.jar:/usr/java/jdk1.8.0_121/jre/lib/sunrsasign.jar:/usr/java/jdk1.8.0_121/jre/lib/jsse.jar:/usr/java/jdk1.8.0_121/jre/lib/jce.jar:/usr/java/jdk1.8.0_121/jre/lib/charsets.jar:/usr/java/jdk1.8.0_121/jre/lib/jfr.jar:/usr/java/jdk1.8.0_121/jre/classes
        ```
    1. Extension ClassLoader 负责加载 JAVA_HOME/lib/ext 和系统变量java.ext.dirs指定的路径中的所有库。    
    1. Application ClassLoader 负责加载用户类用户路径中的类，设定的classpath(对应的jvm参数是 -cp 或 -classpath不支持通配符)。   
    
1. 类的加载行为中用户能控制的主要就是字节码生成(javaagent)和类加载器两部分。    
1. 
    


1. 配置一个线上运行的应用需要配置的参数:堆内存大小,垃圾收集器选择,崩溃的时候dump core文件，开启JMX



            
