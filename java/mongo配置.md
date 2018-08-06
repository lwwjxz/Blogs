1.  replica-set模式下，下面的replica-set参数可以只配置primary的，服务器会返回集群信息缓存在应用中。不过当primary发生变更时新启的java应用将会连不上数据库。
所以还是配个多个ip比较好。    
```
    <mongo:mongo-client id="mongo"  replica-set="localhost:30001,localhost:30002,localhost:30003"  >
        <mongo:client-options connections-per-host="${mongodb.options.connectionPerHost}" write-concern="${mongodb.write-concern}"
                       connect-timeout="${mongodb.options.connectionTimeout}"/>
    </mongo:mongo-client>
```
