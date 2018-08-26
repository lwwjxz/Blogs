1. spring设计目标:spring为开发者提供一个一站式的轻量级应用开发平台。作为平台，spring抽象了我们在许多开发应用中遇到的共性问题。   
1. ioc把依赖管理交给容器而不是程序员。    
1. BeanFactory和ApplicateContext区别，ApplicationContext作为容器的高级形态而存在，在BeanFactory的基础上增加了许多面向框架的特性，同时对应用环境做了适配。    
![](https://github.com/lwwjxz/Blogs/blob/master/image/WX20180825-223408%402x.png)
1. BeanFactory： 定义了一些获取bean和判断bean属性的方法。    
1. ListableBeanFactory: 除了父接口的方法还定义了一些获取beandefinition的方法。    
1. AutowireCapableBeanFactory: 定义了一些获取注解信息的方法。   
1. HierarchicalBeanFactory: 提供了获取父容器和判断是当前容器(不包括父容器)中的bean。   
1. ConfigurableBeanFactory：较复杂获取指定bean的依赖，增加BeanPostProcessor等。    
1. BeanDefinition是对象依赖关系的抽象。     
1. MessageSource可以做最为自己的应用字体设计message。[参考](http://elim.iteye.com/blog/2392583)     
1. ResourceLoader 用来加载资源。    
1. ApplicationEventPublisher[事件机制](https://www.jianshu.com/p/dcbe8f0afbdb)     
    1. ApplicationContext完成bean的装配和初始化后(非lazy-init的singleton bean会加载后就初始化)，会尝试创建一个eventMultiCaster     
    1. 默认SimpleApplicationEventMulticaster 如果有task则异步执行，如果没有则同步执行。   
    1. 所有的Listener是放在一个concurrentHashMap中的。      
1. ApplicationContext多了一些上下文相关的信息。     
1. ConfigurableApplicationContext设置环境变量，ApplicationListener，BeanFactoryPostProcessor[(修改bean的配置信息)](https://blog.csdn.net/xiao_jun_0820/article/details/7242379),parent容器。    
1. WebApplicationContext:获取servlet的上下文。    
    
1. Bean默认是懒加载的，但是这本书上好像说反了。    
1. Ioc容器的初始化过程:       
    1. Resource的定位。      
    1. BeanDefinition的载入。      
    1. BeanDefinition的注册。      
    
