1. ignoreDependencyInterface     
2. ignoreDependencyType   
3. ScopedProxyMode   




1. 将正在创建的beanname放到prototypesCurrentlyInCreation中，创建完后再删除，这样单线程的情况下只要当前创建的bean出现在prototypesCurrentlyInCreation中则说明产生了循环依赖。    
2. 单例的循环依赖在前面处理了所以代码能运行到此处说明已经不是单例的循环依赖了。   


如果bean是由factoryBean生成的，则bean的缓存里value值为factoryBean的实例，取的时候返回的是factoryBean.getObject对象。