1. [Spring 双亲容器](https://blog.csdn.net/zly9923218/article/details/51416267)      
    1. 这个时候子容器就可以引用父容器中的bean，但是父容器是不能够引用子容器中的bean的，并且各个子容器中定义的bean是互不可见的，这样也可以避免因为不同的插件定义了相同的bean而带来的麻烦。
1. [Spring、SpringMVC父子容器关系浅析](https://blog.csdn.net/wuseyukui/article/details/53009440)   
2. [spring MVC 父子容器八股文](https://segmentfault.com/a/1190000039761203)     
3. [spring mvc 配置](https://www.cnblogs.com/grasp/p/11042580.html)    
4. spring boot 中spring mvc 和spring 是一个容器管理的， 实现ApplicationContextAware接口degug就可以证实。原因
   1. 传统的spring mvc 项目是手动配置application.xml文件的，分开配置清爽一点，切换web层时比较好切换，比如要把springmvc切换成struct。       
   2. spring boot 几乎是零配置的，如果还分父子容器就需要程序员关自己写的代码在哪个容器里，这就要增加配置而且是不需要的配置。     