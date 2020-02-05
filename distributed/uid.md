1. uid基本特性   
  1. 唯一性   
1. uid的优秀特性   
  1. 有序递增   
  1. 高可用性    
  1. 带时间    
  1. 递增信息隐藏即不能从id上看出订单量等敏感信息。这一点与有序性递增是互斥的   
1. [各种方案的优缺点](https://juejin.im/post/5b3a23746fb9a024e15cad79)。   
  1. uuid 太长，无序，不可读。   
  1. 数据库自增id     
  1. Redis incr 和 incrby自增原子命令生成。  

  1. Twitter snowflake算法 依赖于机器的始终如果各个机器的始终不同步可能造成小范围无序。时钟回拨的问题  
  1. 百度 snowflake 机器码是动态获取的跟Twitter snowflake相比不用    
  1. [美团Leaf](https://tech.meituan.com/2017/04/21/mt-leaf.html)   
    1. Leaf segment : 适合不怕保留信息，也不需要日期信息的场景     
    1. Leaf snowflake  workId一样的时候也就是同一台机器的时候时钟回调才会导致uid的重复    
       ```
       若写过，则用自身系统时间与leaf_forever/${self}节点记录时间做比较，若小于leaf_forever/${self}时间则认为机器时间发生了大步长回拨，服务启动失败并报警。
若未写过，证明是新服务节点，直接创建持久节点leaf_forever/${self}并写入自身系统时间，接下来综合对比其余Leaf节点的系统时间来判断自身系统时间是否准确，具体做法是取leaf_temporary下的所有临时节点(所有运行中的Leaf-snowflake节点)的服务IP：Port，然后通过RPC请求得到所有节点的系统时间，计算sum(time)/nodeSize。
若abs( 系统时间-sum(time)/nodeSize ) < 阈值，认为当前系统时间准确，正常启动服务，同时写临时节点leaf_temporary/${self} 维持租约。
否则认为本机系统时间发生大步长偏移，启动失败并报警。
每隔一段时间(3s)上报自身系统时间写入leaf_forever/${self}。
       ```
