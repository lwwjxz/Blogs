1. 查看当前公司用版本号。  
`db.runCommand({"buildInfo":1}) `   结果:`3.0.15`        
1. 部署replica-set模式。  
`xxx@server1$ mongod --replSet name -f mongod.conf --fork`    
`xxx@server2$ mongod --replSet name -f mongod.conf --fork`    
`xxx@server3$ mongod --replSet name -f mongod.conf --fork`    

1. 建表。   

1. 导入数据。   
1. 重启。   









1. replica-set模式primary挂了，secondary会自动将一个成员升级为primary。  
1. 默认情况下secondary节点会拒绝读请求和写请求，查询会报`not master`错误。   
1. connectionxxxxx.setSlaveOk()方法可以设置获取对sencondary的读取权限。该方法是对connection的不是对数据库的。secendary不能数据。   
1. replica-set模式下关闭副本集  replicaSet.stopSet()。   
1. 修改副本集配置的行为(除添加成员)，时又比较短的时间无法连接到数据库，因为重新配置的最后一步是关闭所有连接。
