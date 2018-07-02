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
    最主要的危险操作是下面这三种： 
        1. jmap -dump 
这个命令执行，JVM会将整个heap的信息dump写入到一个文件，heap如果比较大的话，就会导致这个过程比较耗时，并且执行的过程中为了保证dump的信息是可靠的，所以会暂停应用。

        2. jmap -permstat 
这个命令执行，JVM会去统计perm区的状况，这整个过程也会比较的耗时，并且同样也会暂停应用。

        3. jmap -histo:live 
这个命令执行，JVM会先触发gc，然后再统计信息。

上面的这三个操作都将对应用的执行产生影响，所以建议如果不是很有必要的话，不要去执行。
    1. 分析规避  
另外，在排查问题的时候，对于保留现场信息的操作，可以用gcore [pid]直接保留，这个的执行速度会比jmap -dump快不少，之后可以再用jmap/jstack等从core dump文件里提取相应的信息，不过这个操作建议大家先测试下，貌似在有些jdk版本上不work。
    
