1. new Tomcat()什么都没干，只是实例化。    
1. 设置org.apache.catalina.startup.Tomcat#basedir    
1. new一个http1.1协议的Connector     
1. 新建一个server     
		新建一个service add进server      
1. 将connector add进service      
1. 定制connector:初始化协议，设置压缩，配置ssl等，等各种定制器对connecor进行定制化。      
1. connctor社会别设置为tomcat实例的属性。     
1. 在service中初始化一个engine，并在engine中初始化一个后生成一个host。      
1. new context()并add进host. 一个context代表一个web应用     
	 
