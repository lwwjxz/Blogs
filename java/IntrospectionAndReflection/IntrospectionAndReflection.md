1. Introspection uses reflection, the relationship between Introspection and Reflection can be seen as similar to JavaBeans and other Java classes.
1. 内省是用反射实现的，内省其实是操作javaBean的工具类。apache中的相关包名都在beanutils。
1. 反射是一切框架的基础，
	1. 试想一下如果没有反射spring要怎么实现呢。spring的实现其实是把对象放在一个map中的。如果没有反射只能new，但是又没有class文件没法new。
	1. spring mvc 也是 dispatchServlet要调用各种controller，但是因为都不能new，所以没有发射就没有框架。
1. [参考](https://www.guru99.com/java-reflection-api.html)    
  	1. 反射是指在运行时分析和修改class。   
