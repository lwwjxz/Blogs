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
       
