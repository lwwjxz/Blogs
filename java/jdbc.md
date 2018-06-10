[JDBC驱动四种类型](https://my.oschina.net/u/1777956/blog/626858)   

>  现在大部分java应用都是用的类型四`类型4：数据库协议驱动`,其他的了解一下就行,读了这篇文字的感谢是任何事物的出现和发  展都跟当时的环境有关，java刚出生的时候只能适应环境最方便的方式就是桥接ODBC虽然有各种问题但这是性价比最高的实现方案，当java发展的比较牛逼后就可以制定标准让别人来实现。而我们在学东西的时候也要根据当下的场景学最有用的和最关键的东西，其中一些比较基础的东西是永远不会过时的。


1. JDBC全称为java database connectivity，是sun公司指定的java数据库连接技术的简称。
他是sun公司和数据库开发商共同开发出来的独立于DBMS的应用程序接口，它为java程序员进行数据库编程提供了`统一`的API。  
2. 面向接口，接口实现不同对于程序员来说是透明的不用关心。试想如果没有jdbc所有的数据库厂商各自开发自己的驱动程序员不但要学习不同驱动的用法如果想要更换数据库的话工作量重写一遍持久层。 
3. jdbc把对数据库的访问抽象成了统一的接口。 
3. jdbc不光对数据库的访问做了统一抽取，把数据库驱动的管理也抽象成一个类DriverManager。(模板模式)如果不统一所有的应用程序中都要各自实现一样的功能，造成大量的模板代码。  
1. [DataSource引入了线程池相关概念](http://blog.51cto.com/lavasoft/265073)   
2. DataSource选型  
    > [数据库连接池性能比对(hikari druid c3p0 dbcp jdbc)](https://blog.csdn.net/IT_faquir/article/details/70999862)比较结果为druid和c3p0比较好且成熟，但是druid支持监控，扩展性强，和阿里云上的一些产品结合的比较好比如DRDS，TDDL等 ,druid支持的功能比较多，如安全方面的sql拦截，监控(耗时，连接泄漏)，数据库密码加密，还在维护(其他已不再维护) 
1.  数据库中间件选择  
    >1. mycat不是阿里出的，目前不更新也不修复BUG，开源的世界想着加个QQ群还收费，唉，迟早被淘汰(网上的评论)。
    >2. 需要继续研究。   
  
1. Connection,PreparedStatement,ResultSet 关闭
    >1. 如果你不使用连接池，那么就没有什么问题，一旦Connection关闭，数据库物理连接就被释放，所有相关Java资源也可以被GC回收了。但是如果你使用连接池，那么请注意，Connection关闭并不是物理关闭，只是归还连接池，所以PreparedStatement和ResultSet都被持有，并且实际占用相关的数据库的游标资源，在这种情况下，只要长期运行，往往就会报“游标超出数据库允许的最大值”的错误，导致程序无法正常访问数据库。   
    >2. PreparedStatement为什么要关闭猜想:因为PreparedStatement要从数据库获取ResultSet所以要占用资源，所以要关闭。   
    >3. ResultSet需要从数据库读取数据所以要占用资源，所以要也要关闭。
1. PreparedStatement和Statement的区别:  
    >1. 使用PreparedStatement的好处是数据库会对sql语句进行预编译，下次执行相同的sql语句时，数据库端不会再进行预编译了，而直接用数据库的缓冲区，提高数据访问的效率。   
    >2. PreparedStatement 能防止sql注入，因为PreparedStatement提前预编译好的回把参数转换为字符串，而不是sql语句。但是Statement就是纯粹的sql语句。   
    >3. PreparedStatement不支持表名，列名 order by X等，只支持参数.Placeholders ? can only be used for parameter values but not with column and sort order directions.   [参考1](https://stackoverflow.com/questions/12430208/using-a-prepared-statement-and-variable-bind-order-by-in-java-with-jdbc-driver)  [参考2](https://www.jianshu.com/p/643866408bb7)    
    >4. [mybatis相关](http://www.cnblogs.com/friends-wf/p/4227999.html)  
1. 团队越来越大数据库连接不够用，问题怎么解决？:答:部署一个远程的jndi数据库，大家公用一个jndi datasource。   
1. jndi datasource和普通datasource的优缺点:  
    >1. 优点  
    
        > > 1. 应用中不用因为jdbcdriver(个人认为意义不大)  
        > > 2. 多个应用公用一个连接池，数据库的连接不够用的时候非常有用。  
        > > 2. 应用中不用关心datasource的配置，dev,test,prod多个环境没有区别。  
        > > 4. 支持XA事务。`?????` 
    >2. 缺点  
    
        > > 1. 需要servlet容器部署jdbcdatasource  


