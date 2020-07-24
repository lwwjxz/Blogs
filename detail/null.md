1. java         
  1. 问题      
        null引起各种if判断。        
  2.解决方案Optional    
        1. Optional目前并不为了用if(Optional.ispresent) 代替if(null == object)，而是为了减少处理对象需要的非空判断，可以避免大多数场景下的非空判断，且便于流程编程用起来比较爽。    
        2. [详情](https://www.cnblogs.com/rjzheng/p/9163246.html)           
2. mysql
  1. 问题
    1. 可空列需要更多的存储空间,还需要mysql做一些特殊处理      
    2. mysql难以优化引用可空列查询，会使索引、索引统计和值(sum)更加复杂       
    3. null值无法做到原地更新容易发生索引分裂。        
    4. 逻辑计算 < > = != not in 等总是返回false容易出错。比如查询不等于5岁的所有人查不出年龄列为null的人。        
    5. 
