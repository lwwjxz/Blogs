1. 理解模式不能从形式上看，因为是一个不好描述的抽象的概念，比如一个接口A，接口的实现AImpl,AImpl中有用到一个String类这个形式上完全属于adapter模式但是很明显不是所以模式是个比较抽象的概念还是要看本质不能看形式。   
1. 理解adapter和bridge的区别，adapter主要解决的是让现有的类、对象一起工作的问题，bridge主要是在设计阶段为了把相互配合的两个或多个对象分开实现的设计模式。   
1. Decorator Pattern focuses on dynamically `adding functions` to an object, while Proxy Pattern focuses on controlling access to an object. 以下为形式上的区别不是本质的区别：Relationship between a Proxy and the real subject is typically set at compile time, Proxy instantiates it in some way, whereas Decorator is assigned to the subject at runtime, knowing only subject's interface.  
1. 模板方法设计模式:定义一个操作中算法的骨架，而将一些步骤的实现延迟到子类中。    
