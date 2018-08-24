1. [资源下载](https://github.com/naver/pinpoint/releases)     
1. [搭建1](https://www.cnblogs.com/yyhh/p/6106472.html) [搭建2](http://www.herohuang.com/2017/03/01/apm-pinpoint/)     
    1. hbase安装[见](https://github.com/lwwjxz/Blogs/blob/master/bigdata/hbase.md)      
    1. [hbase脚本](https://github.com/lwwjxz/Blogs/blob/master/java/apm/hbase-create.hbase)       
    1. hbase单机版搭建自带zk默认2181端口。      
    1. 应用启动脚本    
    ```
    java -javaagent:/home/junbaor/pinpoint-agent/pinpoint-bootstrap-1.6.2.jar -Dpinpoint.agentId=bbs-web-1 -Dpinpoint.applicationName=bbs-web -jar bbs-web-0.0.1-SNAPSHOT.jar
    ```    
    1. 把pinpointagent目录下 pinpoint.config 文件中 profiler.collector.ip 属性值修改为部署 collector 机器的主机名或 IP

    
    
 
