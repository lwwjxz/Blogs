1. servelet、filter、listener、context-param加载顺序    
    1. 首先说加载顺序：context-param—>listener —> filter —> servlet
    2. 这四类加载顺序与配置顺序无关，对于每一类内部的加载顺序，与配置顺序有关；
    3. listener 和 filter 在初始化的时候，都可能用到context-param里面的信息，所以先加载context-param；
    4. listener 用于监听事件，如：容器的启动与销毁~~会话的建立、断开等。
2. load-on-startup标签的作用，影响了Servlet对象创建的时机
    1. 它的值必须是一个整数，表示servlet被加载的先后顺序
    2. 如果该元素的值为负数或者没有设置，则容器会当Servlet被请求时再加载
    3. 如果值为正整数或者0时，表示容器在应用启动时就加载并初始化这个servlet，值越小，servlet的优先级越高，就越先被加载。值相同时，容器就会自己选择顺序来加载。
3. url-pattern:标签的配置方式有四种：/dispatcherServlet、/servlet/*、*.do、/ 以上四种配置
   1. [参考](https://www.cnblogs.com/51kata/p/5152400.html)     
      1. 精确路径 > 最长路径>扩展名     
      2. /kata/*.jsp 此配置是非法的，路径和扩展名匹配无法同时设置。    
      3. /aa/*/bb 这个是精确匹配，url必须是 /aa/*/bb，这里的*不是通配的含义， 路径匹配中*只能在最后
   2. [ / and /*](https://stackoverflow.com/questions/4140448/difference-between-and-in-servlet-mapping-url-pattern)   
      1. /* 属于路径匹配，并且可以匹配所有request，由于路径匹配的优先级仅次于精确匹配，所以/* 会覆盖所有的扩展名匹配，很多404错误均由此引起所以这是一种特别恶劣的匹配模式，一般只用于filter的url-pattern    
      2. /是servlet中特殊的匹配模式，且该模式有且仅有一个实例，优先级最低，不会覆盖其他任何url-pattern，只是会替换servlet容器的内建default servlet ，该模式同样会匹配所有request。   
      3. 什么是 DefaultSevelet，在什么位置声明它？    
        DefaultSevelet 是处理静态资源的 Sevelet。它在 $CATALINA_HOME/conf/web.xml 中被全局声明。默认形式的声明是这样的。   