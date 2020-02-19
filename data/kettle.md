1. [mac安装启动](https://www.jianshu.com/p/741ed3f9955e)     
1. kettle DB连接创建好后，只有右建->共享才能保存要不会丢失。 
1. sqlserver 指定实例的连接配置，版本7.1 用JNDI的方式连接陈宫，配置如下，JNDI名字为MSSQL， 不是默认端口的不知道能不能成功。  
```
MSSQL/type=javax.sql.DataSource

MSSQL/driver=com.microsoft.sqlserver.jdbc.SQLServerDriver

MSSQL/url=jdbc:sqlserver://;ServerName=10.10.xxx.xx\实例名;databaseName=数据库名; 

MSSQL/user=aaaa

MSSQL/password=xxxxx
```
