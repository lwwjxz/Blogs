1. [dubbo源码分析系列（1）扩展机制的实现](https://my.oschina.net/pingpangkuangmo/blog/508963)
    1. dubbo的扩展机制和java的SPI机制非常相似，但是又增加了如下功能：
        1. 可以方便的获取某一个想要的扩展实现，java的SPI机制就没有提供这样的功能
        2. 对于扩展实现IOC依赖注入功能：     
            举例来说：接口A，实现者A1、A2。接口B，实现者B1、B2。    
            现在实现者A1含有setB()方法，会自动注入一个接口B的实现者，此时注入B1还是B2呢？都不是，而是注入一个动态生成的接口B的实现者B$Adpative，该实现者能够根据参数的不同，自动引用B1或者B2来完成相应的功能
        3. 对扩展采用装饰器模式进行功能增强，类似AOP实现的功能(示例见原文)