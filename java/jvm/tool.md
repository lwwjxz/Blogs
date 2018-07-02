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
    使用方法见 《深入记录Java虚拟机：JVM高级特许与最佳实践》 书签:页面128 
    
