[参考](https://www.sohamkamani.com/blog/2016/06/30/docker-mongo-replica-set/)    
1. 同步是实例级别的，即建库，建表的动作都会同步。   
1. 查看当前公司用版本号。  
  `db.runCommand({"buildInfo":1}) `   结果:`3.0.15`   
1. dockerfile生成镜像。(原项目中已有)  
  ```
  from mongo:3
  # MAINTAINER
  MAINTAINER lian

  RUN sed -i "s/deb.debian.org/mirrors.163.com/g" /etc/apt/sources.list
  RUN sed -i "s/security.debian.org/mirrors.163.com/g" /etc/apt/sources.list
  # 更新软件开库
  RUN apt-get update
  RUN apt-get upgrade -y
  # 安装net-tools
  RUN apt-get install net-tools   
  # 安装inetutils-ping 
  RUN apt-get install iputils-ping -y


  ```
构建镜像   
`docker pull mongo:3` 生产用的是3.0.15所以此处用3作为基础镜像。   
   

1. 部署replica-set模式。  
  ```
  docker run -d -p 30001:27017 --name mongotest1 --net mongo-cluster-test --ip 192.168.0.101 mongocluster:1.0.0 mongod --replSet my-mongo-set    
  docker run -d -p 30002:27017 --name mongotest2 --net mongo-cluster-test --ip 192.168.0.102 mongocluster:1.0.0 mongod --replSet my-mongo-set

  docker run -d -p 30003:27017 --name mongotest3 --net mongo-cluster-test --ip 192.168.0.103 mongocluster:1.0.0 mongod --replSet my-mongo-set
  ```    



但是这两种方式都是在前台启动Mongodb进程，如果Session窗口关闭，Mongodb进程也随之停止。不过Mongodb同时还提供了一种后台Daemon方式启动，只需要加上一个"--fork"参数即可，值得注意的是，用到了"--fork"参数就必须启用"--logpath"参数,或者mongod.conf设置了--logpath也可以。如下所示：   
```
[root@localhost mongodb]# ./bin/mongod --dbpath=data/db --fork
--fork has to be used with --logpath
[root@localhost mongodb]# ./bin/mongod --dbpath=data/db --fork --logpath=log/mongodb.log 
all output going to: /opt/mongodb/log/mongodb.log
forked process: 3300
[root@localhost mongodb]# 
```


1. 初始化集群     
```
# 在shell中定义对象
config={
    "_id" : "rs",
    "version" : 1, #初始化时值只能是1
    "members" : [
        {
            "_id" : 0,
            "host" : "m1.example.net:27017",
            "priority" : 1
        },
        {
            "_id" : 1,
            "host" : "m2.example.net:27017",
            "priority" : 0.5
        },
        {
            "_id" : 2,
            "host" : "m3.example.net:27017",
            "priority" : 0.5
        }
    ]
}

#连接到其中一台server
db=(new Mongo("ip:port")).getDB("test")


rs.initiate(config)
# 返回
{
"info":"~~~~~~~~~~~~",
"ok":1
}
# 修改副本
rs.add("ip:port")
rs.remove("ip:port")
# 查看当前配置
rs.config() 

```   
1. replica-set模式primary挂了，secondary会自动将一个成员升级为primary。  
1. 默认情况下secondary节点会拒绝读请求和写请求，查询会报`not master`错误。   connectionxxxxx.setSlaveOk()方法可以设置获取对sencondary的读取权限。该方法是对connection的不是对数据库的。secendary不能数据。  
  ```
  db3 = (new Mongo('localhost:30003')).getDB('test');
  db3.setSlaveOk();
  ```
1. replica-set模式下关闭副本集  replicaSet.stopSet()。   
1. 修改副本集配置的行为(除添加成员)，时又比较短的时间无法连接到数据库，因为重新配置的最后一步是关闭所有连接。   
