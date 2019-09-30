[参考1](https://zhuanlan.zhihu.com/p/24272450)  
[参考2](https://zhuanlan.zhihu.com/p/24275518)

日志框架中的各种适配器就是实现跟被替换框架供调用的类名字(全路径包括包名)一模一样的类比如[log4j-over-slf4f](https://github.com/wdev/log4j-over-slf4f)，也有可能只要实现被替换框架的对外的接口即可。
或者者按照facade的要求实现相应的接口比如[tomcat-juli-log4j2](https://github.com/ggrandes/tomcat-juli-log4j2)和[jul-to-slf4j](https://github.com/qos-ch/slf4j/blob/master/jul-to-slf4j/src/main/java/org/slf4j/bridge/SLF4JBridgeHandler.java)
有两种不同的实现方式的原因可能是因为业务代码调用日志框架是寻找实现类的方法不同前者是根据类名，后者是根据实现某个接口来找实现类。也许还有跟多的实现方式。
