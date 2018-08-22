[参考](http://www.cnblogs.com/kerrycode/p/5593204.html)    
1. 慢sql查询需要较高权限 `select * from mysql.slow_log;`     
1. 慢sql标准查询`show variables like "long_query_time";`   
1. log_output：日志存储方式。log_output='FILE'表示将日志存入文件，默认值是'FILE'。log_output='TABLE'表示将日志存入数据库，这样日志信息就会被写入到mysql.slow_log表中。MySQL数据库支持同时两种日志存储方式，配置的时候以逗号隔开即可，如：log_output='FILE,TABLE'。日志记录到系统的专用日志表中，要比记录到文件耗费更多的系统资源，因此对于需要启用慢查询日志，又需要能够获得更高的系统性能，那么建议优先记录到文件。`输出到TABLE对性能有影响`     
