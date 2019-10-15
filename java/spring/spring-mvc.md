1. ContextLoaderListener把webAppliction放到servletContext中。     
2. DispatcherServlet从servletContext获取webAppliction。     
3. 每个url对应一个HandlerMethod，HandlerMethod中有两个关键属性一个是有controller注解的类，另一个是controller注解的类方法。     
4. [HttpMessageConverter序列化和反序列化](https://segmentfault.com/a/1190000012658289)      
5. [HttpMessageConverter 匹配规则](https://segmentfault.com/a/1190000012659486)     
    1. 根据Accept和可以返回的Content-Type交中找一个在Accept中优先级最高的。   
    2. 确定要返回的Content-Type，在Converterlist中找第一个匹配能返回该Content-Type的Converter进行转换。    
