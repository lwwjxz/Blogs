1. 查看当前公司用版本号。  
`db.runCommand({"buildInfo":1}) `   结果:`3.0.15`   
1. dockerfile生成镜像。  
```
# base image
FROM mongo:3
# MAINTAINER
MAINTAINER lian
# 更新软件开库
apt-get update
# 安装Procps
apt-get install Procps
# 安装net-tools
apt-get install net-tools   
# 安装inetutils-ping 
apt-get install inetutils-ping
```
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
      cacheSizeGB: 10
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

replication:
  oplogSizeMB: 10240
  replSetName: spock

security:
  authorization: disabled
  #authorization: enabled

```

1. 启动镜像    
`docker run --name mongo1 -v 物理机路径/data/mongodb1:/data/db -d mongo --config 物理机路径/mongod.conf`
`docker run --name mongo2 -v 物理机路径/data/mongodb2:/data/db -d mongo --config 物理机路径/mongod.conf`
`docker run --name mongo3 -v 物理机路径/data/mongodb3:/data/db -d mongo --config 物理机路径/mongod.conf`

1. 

1. 建表。   
建表。

1. 导入数据。   
1. 重启。   









1. replica-set模式primary挂了，secondary会自动将一个成员升级为primary。  
1. 默认情况下secondary节点会拒绝读请求和写请求，查询会报`not master`错误。   
1. connectionxxxxx.setSlaveOk()方法可以设置获取对sencondary的读取权限。该方法是对connection的不是对数据库的。secendary不能数据。   
1. replica-set模式下关闭副本集  replicaSet.stopSet()。   
1. 修改副本集配置的行为(除添加成员)，时又比较短的时间无法连接到数据库，因为重新配置的最后一步是关闭所有连接。
