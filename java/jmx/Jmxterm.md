[参考](http://zhixinghh-163-com.iteye.com/blog/2399138)     
[参考](http://wiki.cyclopsgroup.org/jmxterm/)    
1. 连接远程jvm`java -jar jmxterm-1.0.0-uber.jar `进入程序的界面`open localhost:prot`。    
1. 连接本地jvm`java -jar jmxterm-1.0.0-uber.jar` 进入程序的界面` open pid`。     
1. 查看某个域(也就是包名)下的所有bean`beans -d 包名`，不加`-d 包名`表示显示所有bean。   
1. 进入某个bean `bean com.haha.mbean:name=cmdExecute,type=CmdExecute with params`
1. beaninfo显示`info`     
1. 执行某个操作`run 方法名`    
