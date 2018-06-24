1. 软件设计。  
1. 多线程，高并发。  
1. 分布式。  
1. 缓存。  
1. 消息队列。  
1. 类加载机制。    
1. 内存模型。  
1. 性能优化。  
1. spring，Hibernate。  
1. 关系型数据库的设计。  
1. shell脚本。  
1. 领域模型。   
1. 高负载、高可用性系统设计和稳定性。  
1. 熟悉IO。  
1. 设计模式。  
1. tomcat。  
1. 熟悉中间件。  
1. 热部署。  
1. 系统设计。  
1. dubbo springCloud。  
1. 流程图 https://www.zhihu.com/question/27440059。    
1. web容器性能调优。  
1. dubbo，springBoot。  
1. review， 新人辅导。  代码整洁之道。 
1. 读写分离。

todo 
1. spring 事务管理源码。  
1. spring aop实现。  


### DB
1. sql调优。  
1. 读写分离，一主多从。[参考](https://blog.csdn.net/u8AHNh95ix6lUC/article/details/79017745)     
    1. 在读多写少的场景下解决度读性能瓶颈的问题。因为读写分离的场景下只有一主，且写操作都是在主库进行的所以读写分离不能解决写性能瓶颈的问题。  
    1. 读写分离实现类型:[参考](https://www.jianshu.com/p/1ac435a6510e)   
        1. 基于程序代码的内部实现:
            1. 在代码中根据select,insert进行路由分类，这类方法也是目前生产环境应用最广泛的，优点是性能好，因为在程序代码中已经将读写的数据源拆分至两个，所以不需要额外的MySQL proxy解析SQL报文，在进行路由至不同数据库节点。灵活比如某些场景下需要从主库中读取，缺点是通常该架构较复杂，运维成本相对较高。  
            1. 读写分离的代码实现[开源](https://github.com/chengdedeng/perseus)   
            > 大部分方案都是通过通过注解和实现spring的AbstractRoutingDataSource类实现都对代码有侵入性，git上有开源的代码perseus但是不知名，所以最后选用的是实时用基于中间件的代理方式吧。
        1. 基于中间代理层实现：
            >代理层一般位于客户端和服务器之间，代理服务器接到客户端请求后通过解析SQL文本再将SQL路由至可用的数据库节点中。优点是程序不需要改造可以实现无缝迁移，可移植性较好。中间件从知名度，用户数量，是否在维护，文档多少，开源成都TDDL只开源了少部分代码(20180624)做了比较从Atlas，cobar，TDDL，mysql-proxy，mycat，heisenberg,Oceanus,vitess,OneProxy 中选择了sharding[官方网站](http://shardingsphere.io/document/current/cn/overview/)。  
        


1. 分库分表。[参考](https://blog.csdn.net/u8AHNh95ix6lUC/article/details/79017745)      
  > 分库分表主要解决数据量大，解决查询是可以用到异构数据。    
