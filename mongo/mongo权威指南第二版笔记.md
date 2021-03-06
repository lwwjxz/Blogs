###  第一章 简介   
1. 易于使用:不采用关系模型主要是为了获得更好的扩展性。    
1. 易于扩展:monogo能够跨集的处理数据和负载。   
1. 特殊的集合类型:在某些时候过期的数据，固定大小的计划。    
1. 不支持join和多行事务等。    
1. mongo能够对文档进行动态填充(dynamic padding),也能预分配数据文件以利用额外的空间来换取文档的性能(空间换时间)。    
1. 只要可能服务器就会把处理逻辑交给客户端。 

### 第二章基础知识    
1. 每个实例可以拥有多个数据库，每个数据库可以拥有多个文档的集合。    
1. 关键字  . $ \0 ""。   
1. mongodb可以区分类型和大小写。    
1. 集合是动态的还有必要使用多个集合吗？有
    1. 便于查找和管理。   
    1. 查询性能好。   
    1. 使创建索引成为可能。   
1. 子集合:blog.post 和 blog.autors 。 父集合甚至没有必要存在。   
1. 每个数据库都有不同的权限，在磁盘上不同的数据库放在不同的文件中。   
1. 保留数据库 admin、local、config。   
1. 启动数据库  `mongod`   
1. 运行shell `mongo`   
1. 在shell 中可以充分利用js库，可以定义和调用js函数。     
    1. 查看执行那个数据库命令 `db`   
    1. 切换数据库命令`use xxx`   
    1. insert    
        ```
        post = {"title":"题目","post":"内容"};
        db.blog.insert(post);
        
        
        insertFunction = function(){
            for(var i=0 ;i<1000000;i++){
            db.collectionName.insert({"foo":"bar"});
            }
        };
          
        insertFunction();
        ```  
     1. update   
        ```
        post.comments=[];    
        db.blog.update({"title":"题目"},post);
        
        ```   
     1. 执行脚本`mongo --quiet ip:port/dbBase  script1.js script2.js`    
     1. .mongorc.js启动shell默认执行。   
     1. ······
1. json 只有null,布尔,数字,字符串,数组和对象六中数据类型。 而bson增加了很多数据类型。      
1. ObjectId：因为在多台服务器上同步自动增加主键即费力又费时。所用下面的方式`4个字节时间戳|3个字节的主机标识|2个字节的PID|3个字节的计数器`        
1. ObjectId：是在客户端生成的(因为`服务端能不做就不做的原则`)      
1. 文档的大小限制，目前最多为16MB  ,查看文档的大小`Object.bsonize(doc)` 整部战争与和平也才3.14MB.   
1. insert是校验。 有没有_id字段没有的话自动生成，有没有大于16兆，类型是否支持。校验是在客户端做的，还是因为`服务端能不做就不做的原则`    
1. 快速删除`db.collectionName.remove({});`    remove后会重建索引。相当于清空集合     
1. 快速删除`db.collectionName.drop();` 删除列，相等于删除表。   
1. 不要说skip略过大量的数据，这样性能低。   
1. 个人推断:游标相当于客户端指向服务器某个位置的指针，当服务器上的文档发生变化时可能会变。所以读锁和写锁是互斥的。   

### 第五章 索引   
1. `db.currentOp()`查看当前执行的操作。   
1. mongodb拒绝对大于32MB的数据在内存中排序，所以要合适的索引。    
1. mongodb尝试了多个查询计划，则`millis`显示的是这些查询计划花费的总时间。   
1. mongodb查询计划优化     
        1. 如果有一个索引能够精确匹配一个查询，就会选择该索引。    
        1. 如果没有精确匹配的所以，会让可能的索引并行执行，选择返回最快的。    
        1. 记住返回最快的执行计划，下线同一个查询就有该计划。     
1. 修改或重建索引会阻塞所有的读写方法。除非指定background选项，这样建索引会慢的多。    
1. 全文索引(entry和entries应是匹配的)。    
1. 地理空间索引。    
1. GridFS: 使用方便，性能比较差。   
1. 哈希索引（Hashed Index）是指按照某个字段的hash值来建立索引，目前主要用于MongoDB Sharded Cluster的Hash分片，hash索引只能满足字段完全匹配的查询，不能满足范围查询等。    

### 第八章  引用程序设计  
1. 范式和反范式     
1. 子文档只能在子文档或者引用数量不是特别大的情况下有效发挥作用。这种情况下用关系型数据库会不会好一点呢？   

### 第九章  创建副本集

1. 大多数存在才能选到主节点，如果存活的不是大多数了则停止对外服务。主要是防止脑裂，造成多个主节点。    



### 第十三章 分片    
1. 几乎所有的数据库软件都能进行手动分片。应用需要维护和若干个不同数据库的链接。每个连接还是完全独立的。引用程序管理不同服务器上不同数据的储存，还管理
在合适的数据库上查询数据的工作。这种方法能够很好的工作但是难以维护，比如向集群添加节点或从集群删除节点都很困难，调整数据分布和负载模式也不轻松。   
1. mongodb支持自动分片，可以使数据库架构对应用程序不可见，也可以简化系统管理。对应用程序而言，好像始终在使用一个单机的mongoDB服务器一样。另外，mongodb自动处理数据在分片上的分布，也更容易添加和删除分片。    
1. 不过从开发角度还是从运营角度来说，分片都是最困难的mongoDB配置方式。    
1. 如果从一个未分片的系统转化为几个分片的系统，性能通常会有所下降。由于迁移数据，维护元数据，路由等开销，少量分片的系统与未分片的系统相比通常延迟更大。因此至少应该创建3个以上的分片。   

### 第十七章 了解应用的动态    
1. 






       
