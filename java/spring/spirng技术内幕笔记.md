1. spring设计目标:spring为开发者提供一个一站式的轻量级应用开发平台。作为平台，spring抽象了我们在许多开发应用中遇到的共性问题。   
1. ioc把依赖管理交给容器而不是程序员。    
1. BeanFactory和ApplicateContext区别，ApplicationContext作为容器的高级形态而存在，在BeanFactory的基础上增加了许多面向框架的特性，同时对应用环境做了适配。    
![](https://github.com/lwwjxz/Blogs/blob/master/image/WX20180825-223408%402x.png)
1. BeanFactory： 定义了一些获取bean和判断bean属性的方法。    
1. ListableBeanFactory: 除了父接口的方法还定义了一些获取beandefinition的方法。    
1. AutowireCapableBeanFactory: 定义了一些获取注解信息的方法。   
1. HierarchicalBeanFactory: 提供了获取父容器和判断是当前容器(不包括父容器)中的bean。   
1. BeanDefinition是对象依赖关系的抽象。     
1. MessageSource可以做最为自己的应用字体设计message。   


1. Bean默认是懒加载的，但是这本书上好像说反了。    
1. Ioc容器的初始化过程:       
    1. Resource的定位。      
    1. BeanDefinition的载入。      
    1. BeanDefinition的注册。      
    
