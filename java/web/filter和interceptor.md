1. filter和interceptor都是责任链模式的具体实现但又跟具体的责任链模式不同[filter详解](http://blogzhoubo.iteye.com/blog/1738358)  [interceptor详解](http://elim.iteye.com/blog/1750680)  
`todo 有空可以看下源码`。  
2. [Spring Interceptor vs Filter 拦截器和过滤器区别 ](http://einverne.github.io/post/2017/08/spring-interceptor-vs-filter.html#filter-%E4%BD%BF%E7%94%A8)  
能用spring Interceptor就用Interceptor，除非有现成的Filter可以用，比如`org.springframework.web.filter.CharacterEncodingFilter`。
