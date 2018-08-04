1. 查看当前公司用版本号。  
`db.runCommand({"buildInfo":1}) `   结果:`3.0.15`   
1. dockerfile生成镜像。  
```
# base image
FROM mongo:3
# MAINTAINER
MAINTAINER lian
# 更新软件开库
RUN apt-get update
# 安装Procps
RUN apt-get install Procps
# 安装net-tools
RUN apt-get install net-tools   
# 安装inetutils-ping 
RUN apt-get install iputils-ping -y
```
构建镜像   
`docker pull mongo:3` 生产用的是3.0.15所以此处用3作为基础镜像。   
`docker build -t mongo-lian:version1 .`   

1. 部署replica-set模式。  
`xxx@server1$ mongod --replSet name -f mongod.conf --fork`     
`xxx@server2$ mongod --replSet name -f mongod.conf --fork`     
`xxx@server3$ mongod --replSet name -f mongod.conf --fork`     

docker 启动 `docker run --name some-mongo -d mongo:tag`     

但是这两种方式都是在前台启动Mongodb进程，如果Session窗口关闭，Mongodb进程也随之停止。不过Mongodb同时还提供了一种后台Daemon方式启动，只需要加上一个"--fork"参数即可，值得注意的是，用到了"--fork"参数就必须启用"--logpath"参数,或者mongod.conf设置了--logpath也可以。如下所示：   
```
[root@localhost mongodb]# ./bin/mongod --dbpath=data/db --fork
--fork has to be used with --logpath
[root@localhost mongodb]# ./bin/mongod --dbpath=data/db --fork --logpath=log/mongodb.log 
all output going to: /opt/mongodb/log/mongodb.log
forked process: 3300
[root@localhost mongodb]# 
```
由于是docker镜像启动参数不知道怎么加，所以全写到mongod.conf里边     

```
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: false
  path: /data/mongodb/logs/mongodb.logs

# Where and how to store data.
storage:
  indexBuildRetry: true
  directoryPerDB: true
  dbPath: /data/mongodb/data
  journal:
    enabled: true
  syncPeriodSecs: 60
  engine: wiredTiger  #启用WT引擎
  wiredTiger:
    engineConfig:
      cacheSizeGB: 10  #引擎使用的最多内存大小
      journalCompressor: snappy
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true

#  engine:
#  mmapv1:
#  wiredTiger:

# how the process runs
processManagement:
  fork: true  # fork and run in background
  pidFilePath: /data/mongodb/data/mongo.pid  # location of pidfile

# network interfaces
net:
  port: 27017
  maxIncomingConnections: 65536
  ipv6: false


operationProfiling:
  slowOpThresholdMs: 100
  mode: slowOp

# 副本信息
replication:
  oplogSizeMB: 10240
  replSetName: spock

security:
  authorization: disabled
  #authorization: enabled

```

1. 启动镜像    
`docker run --name mongo1 -v 物理机路径/data/mongodb1:/data/db -p 27011:27017 -d mongo --config 物理机路径/mongod.conf`    
`docker run --name mongo2 -v 物理机路径/data/mongodb2:/data/db -p 27012:27017 -d mongo --config 物理机路径/mongod.conf`    
`docker run --name mongo3 -v 物理机路径/data/mongodb3:/data/db -p 27013:27017 -d mongo --config 物理机路径/mongod.conf`    
`docker run --name mongo4 -v 物理机路径/data/mongodb4:/data/db -p 27014:27017 -d mongo --config 物理机路径/mongod.conf`     

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
1. 设置好后多建几个库看能不能同步，确定副本模式是针对整个实例的还是针对库的？
1.    

1. 导入数据。   
1. 重启。   









1. replica-set模式primary挂了，secondary会自动将一个成员升级为primary。  
1. 默认情况下secondary节点会拒绝读请求和写请求，查询会报`not master`错误。   
1. connectionxxxxx.setSlaveOk()方法可以设置获取对sencondary的读取权限。该方法是对connection的不是对数据库的。secendary不能数据。   
1. replica-set模式下关闭副本集  replicaSet.stopSet()。   
1. 修改副本集配置的行为(除添加成员)，时又比较短的时间无法连接到数据库，因为重新配置的最后一步是关闭所有连接。
