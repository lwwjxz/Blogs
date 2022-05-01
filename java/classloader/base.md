1. [参考](https://blog.csdn.net/briblue/article/details/54973413)      
    1. ClassLoader的parent创建时指定，不知道默认为AppClassLoader。      
    1. BootstrapClassLoader可以是其他类加载器逻辑上的父类，但是其他的classloader.getParent()不可能得到BootstrapClassLoader。如果逻辑
    上的父类为BootstrapClassLoader的getParent()只能得到null。    
    1. java中的核心类库加载器为BootstrapClassLoader，比如 int.class 但是int.class.getCloassLoader()结果为null。     
    2. 双亲委派的好处:    
            1. 减少了类的重复加载。     
            2. 保证了安全性。因为Bootstrap ClassLoader在加载的时候，只会加载JAVA_HOME中的jar包里面的类，如java.lang.Integer，那么这个类是不会被随意替换的，除非有人跑到你的机器上， 破坏你的JDK。      
1. [打破双亲加载模型](https://www.cnblogs.com/hollischuang/p/14260801.html)     
        1. tomcat中的WebAppClassLoader是先加载自己path下的类，加载不到再委托给父类。打破了双亲加载模型。    
        2. JDBC 等SPI机制通过ContextClassLoader破坏双亲委派模型。因为ServiceLoader是由Bootstrap加载的，Bootstrap是无法加载三方实现的类的。    
1. 为什么要多个类加载器1个不行吗？为什么要搞双亲委派模式？     
    1. Each class loader is designed to load classes from different locations. For instance, you can actually create a class loader that will load a class file from a networked server or download the binary of a class from a remote web server, etc. The logic that performs this operation is baked into the class loader itself and provides a consistent interface so that clients can load classes regardless of how the class loader actually performs the loading. The BootstrapClassLoader is capable of loading classes from the JVM_HOME/lib directory...but what if you need to load them from a different location??     
In short, because there as an infinite (well, not quite) number of ways to load classes and there needs to be a flexible system to allow developers to load them however they want.
    2. 在需要多个classLoader的前提下，好处就显而易见。a. 减少了类的重复加载.  b. 保证了安全性。因为Bootstrap ClassLoader在加载的时候，只会加载JAVA_HOME中的jar包里面的类，如java.lang.Integer，那么这个类是不会被随意替换的，除非有人跑到你的机器上， 破坏你的JDK。    
1. [类的加载过程](https://blog.csdn.net/zhangliangzi/article/details/51319033)    
 
       
