[参考](http://zhixinghh-163-com.iteye.com/blog/2399138)     
[参考](http://wiki.cyclopsgroup.org/jmxterm/)    
1. 连接远程jvm`java -jar jmxterm-1.0.0-uber.jar -l localhost:prot`。    
1. 连接本地jvm`java -jar jmxterm-1.0.0-uber.jar open pid`。     
1. 查看某个域(也就是包名)下的所有bean`bean -d 包名`，不加`-d 包名`表示显示所有bean。   
1. 进入某个bean `info beaninfo(bean命令查出来的bean相关信息)`     
1. 执行某个操作`run 方法名`    
