[参考1](https://zhuanlan.zhihu.com/p/24272450)  
[参考2](https://zhuanlan.zhihu.com/p/24275518)

日志框架中的各种适配器就是实现跟目标框架供调用的类名字(全路径包括包名)一模一样的类比如[log4j-over-slf4f](https://github.com/wdev/log4j-over-slf4f)，也有可能只要实现目标框架的对外的接口
就可以了比如[tomcat-juli-log4j2](https://github.com/ggrandes/tomcat-juli-log4j2)
有两种不同的实现方式的原因可能是因为业务代码调用日志框架是寻找实现类的方法不同前者是根据类名，后者是根据实现某个接口来找实现类。也许还有跟多的实现方式。
