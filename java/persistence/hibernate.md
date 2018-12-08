1. [Hibernate教程-终极指南](https://www.javacodegeeks.com/2015/06/hibernate%E6%95%99%E7%A8%8B.html#introduction)
    1. Hibernate查询语言（HQL）独立于数据库供应商，而mybatis并没有。
    2. 单表的增删改查，Hibernate和mybatis一样方便，就是当需要修改字段的时候mybaitis比较麻烦(虽然可以重新字段生产一遍)
1. [从demo总结](https://howtodoinjava.com/hibernate/hibernate-3-introduction-and-writing-hello-world-application/)
    1. 根据entity生成表结构，所以不用手动建表`@Column(name = "EMAIL", unique = true, nullable = false, length = 100)`
    建表的时候可以用该特性但是对表的其他操作还是手工完成比较好，因为该表结构不经过人工审核还是比较危险的。比如性能，误操作等。
    2. 
