1. spring设计目标:spring为开发者提供一个一站式的轻量级应用开发平台。作为平台，spring抽象了我们在许多开发应用中遇到的共性问题。   
1. ioc把依赖管理交给容器而不是程序员。    
1. BeanFactory和ApplicationContext区别，ApplicationContext作为容器的高级形态而存在，在BeanFactory的基础上增加了许多面向框架的特性，同时对应用环境做了适配。    
![](https://github.com/lwwjxz/Blogs/blob/master/image/WX20180825-223408%402x.png)
1. BeanFactory： 定义了一些获取bean和判断bean属性的方法。    
1. ListableBeanFactory: 除了父接口的方法还定义了一些获取beandefinition的方法。    
1. AutowireCapableBeanFactory: 定义了一些获取注解信息的方法。   
1. HierarchicalBeanFactory: 提供了获取父容器和判断是当前容器(不包括父容器)中的bean。   
1. ConfigurableBeanFactory：较复杂获取指定bean的依赖，增加Bean
Processor等。    
1. BeanDefinition是对象依赖关系的抽象。     
1. MessageSource可以做最为自己的应用字体设计message。[参考](http://elim.iteye.com/blog/2392583)     
1. ResourceLoader 用来加载资源。    
1. ApplicationEventPublisher[事件机制](https://www.jianshu.com/p/dcbe8f0afbdb)     
    1. ApplicationContext完成bean的装配和初始化后(非lazy-init的singleton bean会加载后就初始化)，会尝试创建一个eventMultiCaster    
    1. 默认SimpleApplicationEventMulticaster 如果有task则异步执行，如果没有则同步执行。   
    1. 所有的Listener是放在一个concurrentHashMap中的。      
    2. Spring事件机制是观察者模式的一种实现，但是除了发布者和监听者两个角色之外还有一个EventMultiCaster的角色负责把事件转发给监听者。这样很好的解耦了事件发布者和监听者。
1. ApplicationContext多了一些上下文相关的信息。     
1. ConfigurableApplicationContext设置环境变量，ApplicationListener，BeanFactoryPostProcessor[(修改bean的配置信息)](https://blog.csdn.net/xiao_jun_0820/article/details/7242379),parent容器。 
2. [BeanPostProcessor](https://uule.iteye.com/blog/2094549)   
3. BeanPostProcessor是bean实例化完成后再init方法前后执行，BeanFactoryPostProcessor是BeanFactory加载完成后在方法的前后执行。
1. WebApplicationContext:获取servlet的上下文。    
    
1. Bean默认是懒加载的，但是这本书上好像说反了。    
1. Ioc容器的初始化过程:       
    1. Resource的定位。      
    1. BeanDefinition的载入。      
    1. BeanDefinition的注册。      
    
    
1. ClassPathXmlApplicationContext容器加载过程。  
    1. AbstractRefreshableConfigApplicationContext#setConfigLocations 初始化系统信息比如jdk版本号，
    1. ConfigurableEnvironment跟父容器的ConfigurableEnvironment合并。     
    1. AbstractRefreshableConfigApplicationContext设置xml配置文件路径。    
    1. AbstractApplicationContext#prepareRefresh
            1. 设置初始化时间，active状态等基本信息。    
            1. 设置系统属性。    
            1. 校验需要容器中需要的属性有没有加载到。    
            1. AbstractApplicationContext#earlyApplicationEvents。    
    1. AbstractApplicationContext#obtainFreshBeanFactory     
            1. refreshBeanFactory       
                1. 设置ignoredDependencyInterfaces        zhi
                1. 设置是否允许重写definition和是否循环依赖标志位。    
                1. 加载beanDefinition(比较复杂的逻辑)。想要自定义schame需要从此次入手。   
                
    1. prepareBeanFactory 实现BeanPostProcessor其中就有加载时植入。     
    1. BeanPostProcessor对象实例化后执行，BeanFactoryPostProcessor BeanFactory加载完后执行。    
    1. finishBeanFactoryInitialization 实例化饥饿加载单例bean除非设置了懒加载[参考](https://blog.csdn.net/u011734144/article/details/72632327)。   
1. 单例并且是通过set方法循环依赖的才能解决。[参考](https://blog.csdn.net/u010644448/article/details/59108799)    
    1. 单例set:spring先设置所有的对象然后再设置对象的属性。    
    1. 单例构造函数不行。     
    1. prototype不行因为spring不会对实例进行缓存。                     
1. AOP面向切面的编程。   
1. 普通人员对优秀架构师的渴望，有了架构师，每个人都可以各自负责自己的“一亩三分地”日子会好过很多。    
1. 面向对象的一个基本原则，让对象尽可能的靠近数据。     
1. java字节码就是class文件。     
1. Spring AOP也是对目标类增强，生成代理类。但是与AspectJ的最大区别在于---Spring AOP的运行时增强，而AspectJ是编译时增强。
曾经以为AspectJ是Spring AOP一部分，是因为Spring AOP使用了AspectJ的Annotation。使用了Aspect来定义切面,使用Pointcut来定义切入点，使用Advice来定义增强处理。虽然使用了Aspect的Annotation，但是并没有使用它的编译器和织入器。其实现原理是JDK 动态代理，在运行时生成代理类。     
1. JDK创建代理对象效率比CGLib高，而CGLib创建的代理对象运行效率比JDK的要高。[spring AOP入门](https://segmentfault.com/a/1190000003000515)[spring AOP入门](https://segmentfault.com/a/1190000003000515)      
1. org.springframework.context.support.AbstractApplicationContext#refresh中调用org.springframework.context.support.AbstractApplicationContext#registerBeanPostProcessors时会把动态代理要代理的内容注册到org.springframework.beans.factory.support.AbstractBeanFactory#beanPostProcessors中让后在org.springframework.context.support.AbstractApplicationContext#finishBeanFactoryInitialization中调用org.springframework.beans.factory.config.ConfigurableListableBeanFactory#preInstantiateSingletons中执行动态代理的逻辑。     

1. springMVC的加载过程。     
![](https://github.com/lwwjxz/Blogs/blob/master/image/WX20180902-230739%402x.png)    
    1. org.springframework.web.context.ContextLoaderListener#contextInitialized，event中包含tomcat容器的上下文ApplicationContextFacade。    
    1. 最终也是调用 org.springframework.context.support.AbstractApplicationContext#refresh。    
    1. WebApplicationContext是父上下文，DispatchServlet会持有子上下文。     
    1. DispatcherServlet也会启动一个WebApplicationContext上线双亲上下文就是ContextLoaderListener启动的WebApplicationContext。     


            
    
