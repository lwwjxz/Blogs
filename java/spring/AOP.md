1. [Spring之LoadTimeWeaver](https://sexycoding.iteye.com/blog/1062372) 
在Java 语言中，从织入切面的方式上来看，存在三种织入方式：编译期织入、类加载期织入和运行期织入。编译期织入是指在Java编译期，采用特殊的编译器，将切面织入到Java类中；而类加载期织入则指通过特殊的类加载器，在类字节码加载到JVM时，织入切面；运行期织入则是采用CGLib工具或JDK动态代理进行切面的织入。 
1. 如果对象实现了接口，默认情况下会采用JDK的动态代理实现AOP，但是可以强制使用CGLID实现AOP。如果目标对象没有实现接口必须采用CGLIB。spring会自动在JDK和CGLIB直接转换。      
1. JDK和CGLIB的区别，JDK只能对实现了接口的类生成代理，CGLIB是针对要代理的类生产一个子类，覆盖其中的方法，所以被代理的类和方法不能声明成final
1. Bean生成代理的时机是在每个Bean初始化之后。
2. [动态代理的位置](https://github.com/lwwjxz/Blogs/blob/master/image/WX20181216-174906%402x.png)
3. [彻底征服 Spring AOP 之 理论篇](https://segmentfault.com/a/1190000007469968)
    join point是所有可以插入代码的点。    
    point cut 是描述一类join point的规则。    
    advice 是想要在point cut 插入的代码。      
    aspect 是advice和point cut的组合。   
