全局唯一id生成的要点:   
全局唯一性：不能出现重复的ID号，既然是唯一标识，这是最基本的要求。   
趋势递增：在MySQL InnoDB引擎中使用的是聚集索引，由于多数RDBMS使用B-tree的数据结构来存储索引数据，在主键的选择上面我们应该尽量使用有序的主键保证写入性能。   
单调递增：保证下一个ID一定大于上一个ID，例如事务版本号、IM增量消息、排序等特殊需求。   
信息安全：如果ID是连续的，恶意用户的扒取工作就非常容易做了，直接按照顺序下载指定URL即可；如果是订单号就更危险了，竞对可以直接知道我们一天的单量。所以在一些应用场景下，会需要ID无规则、不规则。   
上述123对应三类不同的场景，3和4需求还是互斥的，无法使用同一个方案满足。   


1. [UUID](https://www.zhihu.com/question/34876910/answer/88924223)    
    1. UUID有多种算法，不同的算法重复的概率不一样。 重复的概率极低.    
    1. 无法保证趋势递增。可以控制ShardingId。比如某一个用户的文章要放在同一个分片内，这样查询效率高，修改也容易。    
    1. 太长，没有趋势递增所以作为索引来说效率太低。    
1. [高并发分布式系统中生成全局唯一Id汇总](https://www.cnblogs.com/baiwa/p/5318432.html)        
1. [Leaf——美团点评分布式ID生成系统](https://tech.meituan.com/MT_Leaf.html?utm_source=tool.lu)      
        1. uuid： 太长，无序，信息不安全(可能暴露mac地址)    
        1. snowflake：时钟回拨会导致id重复[闰秒](https://coolshell.cn/articles/7804.html)[闰秒对应的处理](https://www.zhihu.com/question/21504563) 可能有些机器处理闰秒不太规范前一秒和本秒的时间戳是一样的。如果出现时间回拨(闰秒的时间戳跟前一秒的一样的)怎么处理。对于时钟回拨的问题snowflake的处理方法是直接抛出异常 ，ntp时间戳。              
        1. 设置数据库的步长和起始值:水平扩展比较困难，id没有单调递增，只是趋势递增，数据库压力很大。   
        ps `猜想：单调递增:严格的递增，  趋势递增：大趋势是递增的有时候肯能不是递增的`   
        
        
1. 比较简单实现方法，没有考虑时间回拨[基于redis的分布式ID生成器](https://github.com/hengyunabc/redis-id-generator)    
        1. [eval 和 evalsha](http://redisdoc.com/script/eval.html)      
        1. [redis time ](http://redisdoc.com/server/time.html)      
        
        


