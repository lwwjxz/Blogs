1. 书签页面32
[参考](https://blog.csdn.net/xyw591238/article/details/51995486)  
[参考](https://www.jianshu.com/p/7248ccef9382)  
[参考](http://yangbolin.cn/2016/11/12/spring-work-01/)  
BeanNameAware 和 BeanFactoryAware 的作用

2. spring 也有 profile跟maven中的作用一样。   
3. 只有单例的setter依赖注入才能解决循环依赖的问题。   
1. 容器加载相关类图(图2-5)的总结。
    1. Registry注册相关。   
    1. Factory用于实例化类的工厂。   
    1. Support增加一些特殊功能。   
1. 配置文件相关类图(图2-6)总结。
    1. Loader 加载配置文件。   
    1. Reader 配置文件转换为BeanDefinition。   
    1. Enviroment 获取Enviroment。  
    1. Parser解析Element。    
1. 配置文件解析，如果自定义的schema需要自定义解析器。需要自定义schema的时候可以参考。      
1. FactoryBean。      
1. AOP是每次初始化bean完成后再生产代理类。   

