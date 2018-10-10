1. jdk1.6 jmx默认是开启的，所以推出开启jmx对应用的性能影响很小。   
1. 常用命令:
    jsp
    ```
    jps -l 输出pid和对应的启动了的全路径。    
    ```
    jstat
    ```
    jstat [option vmid [interval[s|ms] [count]]]      
    vmid 就是pid 如果是远程的格式为[protocl:][//]pid[@host[:port]/servername]      
    常用  
    jstat -class
    jstat -gc    
    ```
    jinfo[参考](https://www.jianshu.com/p/c321d0808a1b)           
    ```
    jps -v 可以查看java应用启动时显示指定的参数；    
    jinfo -flag 参数   查看指定的参数值。如:jinfo -flag MaxMetaspaceSize pid      
    boolean类型的参数修改 jinfo -flag [+|-]<name> PID  其他类型的参数修改jinfo -flag <name>=<value> PID      
    可以修改的参数分两类java -XX:+PrintFlagsInitial | grep manageable和调用HotSpotDiagnostic.getDiagnosticOptions()返回的参数。     
    ```
    jmap[参考](http://www.importnew.com/27804.html)         
    ```
    jmap -histo[:live] <pid>   打印出java堆中各个对象的大小和数量。   
    jmap -dump:[live,]format=b,file=<filename> <pid> 把java堆中的对象dump到本地文件，然后使用MAT进行分析。如果添加了live，只会dump活跃的对象。   
    jmap -heap <pid>  打印java堆的配置情况和使用情况，还有使用的GC算法。    
    jmap -finalizerinfo <pid>    
    常用堆文件分析工具Eclipse Memory Analyzer(MAT)    
    ```
    jstack    
    ```
    -F强制输出
    -l出堆栈外显示关于锁的信息    
    -m如果调用的本地方法可以显示C/C++的栈
    ```
    
    
