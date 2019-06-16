本文档只是对《深入记录Java虚拟机：JVM高级特许与最佳实践》第四章做了概括，解释和补充详见书中的内容。   
1.  jps:查看虚拟机进程     
    1. 命令格式：jps [options ] [ hostid ]    
        1. [options]选项 ：  
        -q：仅输出VM标识符，不包括classname,jar name,arguments in main method   
        -m：输出main method的参数    
        -l：输出完全的包名，应用主类名，jar的完全路径名   
        -v：输出jvm参数   
        -V：输出通过flag文件传递到JVM中的参数(.hotspotrc文件或-XX:Flags=所指定的文件    
        -Joption：传递参数到vm,例如:-J-Xms512m(用法没太搞懂)   
        1.  [hostid]：   
        [protocol:][[//]hostname][:port][/servername]   
        示例`jps -mlv10.134.68.173` 如果需要查看其他机器上的jvm进程，需要在待查看机器上启动jstatd   d结尾在linux上一般表示服务。  
1. jstat:虚拟机统计信息监视(运行期定位虚拟机性能问题的首选工具)    
    使用方法见 《深入记录Java虚拟机：JVM高级特许与最佳实践》     
    
1. jinfo:java配置信息工具。   
    jps 只能查看虚拟机启动时显式指定的参数，jinfo还可以显示默认的参数。  
    jinfo -sysprops 可以查看System.getProperties()的内容显示出来。    
    jinfo 有修改一部分运行期可写的虚拟机参数值。   
1. jmap:用于生成java堆内存快照    
    1. 除了该方法外还有以下方法可以生成堆内存快照   
        >增加启动参数 -XX:+HeapDumpOnOutOfMemoryError 【以下为猜测】应该不会出现性能问题因为已经OOM了，应用已经不能对外提供服务了就谈不上性能了。   
    增加启动参数 -XX:+HeapDumpOnCtrlBreak  
    kill -3发出进程退出信号
    1. 风险提示   
        1. 最主要的危险操作是下面这三种： 
            1. jmap -dump 
这个命令执行，JVM会将整个heap的信息dump写入到一个文件，heap如果比较大的话，就会导致这个过程比较耗时，并且执行的过程中为了保证dump的信息是可靠的，所以会暂停应用。

            2. jmap -permstat 
这个命令执行，JVM会去统计perm区的状况，这整个过程也会比较的耗时，并且同样也会暂停应用。

            3. jmap -histo:live 
这个命令执行，JVM会先触发gc，然后再统计信息。
上面的这三个操作都将对应用的执行产生影响，所以建议如果不是很有必要的话，不要去执行。
  
        1. 另外，在排查问题的时候，对于保留现场信息的操作，可以用gcore [pid]直接保留，这个的执行速度会比jmap -dump快不少，之后可以再用jmap/jstack等从core dump文件里提取相应的信息，不过这个操作建议大家先测试下，貌似在有些jdk版本上不work。 
            >用gcore或gdb创建了核心转储，那么你需要将其转换为一个称为HPROF文件的东西。这些可以由VisualVM，Netbeans或Eclipse的内存分析器工具(以前称为SAP内存分析器)使用。我会推荐Eclipse MAT。要转换文件，请使用命令行工具jmap。    
            `jmap -dump:format=b,file=dump.hprof /usr/bin/java core.1234`   
            dump.hprof是要创建的hprof文件的名称   
            / usr / bin / java是生成核心转储的java二进制版本的路径   
            core.1234是您的常规核心文件。 一般1234就是PID。   
     1. 示例`jmap -dump:format=b,file=/xxxx/xxxx/xxx/filename 56466` 其中file参数指定生成文件的路径，如存在则不生成。  
1. jhat: dump文件分析工具，一般不用应为Eclipse的MAT最好用。   
    注意: 由于dump文件很大一般在64位JDK大内存的服务器上进行。  
1. jstack:用于生成当前时刻的线程快照(一般称为threaddump 或者 javacore文件)   
    1. 生成线程快照的主要目的是定位线程出现长时间停顿的原因，如线程间死锁、死循环、请求外部资源导致的长时间等待。  
    1. http://www.ccblog.cn/84.htm  文章中的工具没找到用VisualVM即可，线程的dump文件也没有生成不过文章讲的原来可以参考下。  
    1. 由于blocked，waiting等有可能只是暂时的，所以要多做几次
1. HSDIS:JIT生成代码反汇编，暂时先不考虑学习该工具。  
1. VisualVM [设置方法](http://blog.51cto.com/lizhenliang/1608005)   
    >ps 一定要加`-Djava.rmi.server.hostname=192.168.1.156`第一次调试的时候忘了加搞了好久没连上。  
    >ps 端口要设置两次-Dcom.sun.management.jmxremote.port=[RMI_PORT] -Dcom.sun.management.jmxremote.rmi.port=[RMI_PORT]其中一个没有rmi.
    >ps 如果hosts文件中没有配置本机ip会产生以下异常`Error: Exception thrown by the agent : java.net.MalformedURLException: Local host name unknow: java.net.UnknownHostException: hostnamexxxx`解决方法在hosts文件中增加配置`本机ip:hostnamexxx`
    >有jstatd和jmx两种方式这里用是jmx的方式
1. [eclipse MAT用法 ](https://blog.csdn.net/wanghuiqi2008/article/details/50724676)   
1. [内存分析工具 MAT 的使用](https://blog.csdn.net/aaa2832/article/details/19419679)    
1. VisualVM的BTrace插件比较难用代替方案[arthas](https://github.com/alibaba/arthas),[greys](https://github.com/oldmanpushcart/greys-anatomy)，arthas是在greys的基础上二次开发然后开源的。      
    
