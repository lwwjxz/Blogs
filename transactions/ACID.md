1. 为什么即使在事务断电了的情况下数据也不会消失:(推测)在每个事务开始之前会先记录支持，即使执行一半断电了也可以在来电重启的时候结束该事务。    
2. [ACID](https://en.wikipedia.org/wiki/ACID_(computer_science))   
    1. A:要么全失败要么全部成功。     
    2. C:ensures that a transaction can only bring the database from one valid state to another,正确状态包括数据库约束和业务上的？基础是符合数据库定义的约束，还要符合业务上的正确比如甲给乙转钱如果甲减了x元而乙没有加相应的钱就不是正确状态(需要业务上保证)。这样看数据库层的一致性只要数据符合约束就可以了     
    3. I:可以理解为并发事务相互影响的程度。       
    4. D:guarantees that once a transaction has been committed, it will remain committed even in the case of a system failure (e.g., power outage or crash).