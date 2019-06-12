1. [java 注解的几大作用及使用方法详解（完）](https://blog.csdn.net/tigerdsh/article/details/8848890)
    1. 在代码中添加信息的一种形式。    
    2. 元注解:注解的注解。   
    3. java.lang.annotation.Annotation 是所有注解继承的接口,并且是自动继承，不需要定义时指定，类似于所有类都自动继承Object。   
    4. Inherited : 在您定义注解后并使用于程序代码上时，预设上父类别中的注解并不会被继承至子类别中，您可以在定义注解时加上java.lang.annotation.Inherited 限定的Annotation，这让您定义的Annotation型别被继承下来。注意注解继承只针对class级别注解有效，RetentionPolicy.RUNTIME级别应该也可以吧。



1. [秒懂，Java 注解 （Annotation）你可以这样学](https://blog.csdn.net/briblue/article/details/73824058)    
2. [深入理解Java：注解（Annotation）自定义注解入门](http://www.cnblogs.com/peida/archive/2013/04/24/3036689.html)
