# [lsof 一切皆文件](https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/lsof.html)
1. 实例1：无任何参数 `lsof| more`    
2. 实例2: 查找某个文件相关的进程`lsof /bin/bash`
3. 实例3：列出某个用户打开的文件信息`lsof -u username` 
4. 实例4：列出某个程序进程所打开的文件信息`lsof -c mysql`
5. 实例5：列出某个用户以及某个进程所打开的文件信息`lsof  -u test -c mysql`
6. 实例6：通过某个进程号显示该进程打开的文件`lsof -p 11968`
7. 实例7：列出所有的网络连接`lsof -i`
8. 实例8：列出所有tcp 网络连接信息`lsof -i tcp`
9. 实例9：列出谁在使用某个端口`lsof -i :3306`
10. 实例10：列出某个用户的所有活跃的网络端口`lsof -a -u test -i`
11. 实例11：根据文件描述列出对应的文件信息`lsof -d 3 | grep PARSER1`说明： 0表示标准输入，1表示标准输出，2表示标准错误，从而可知：所以大多数应用程序所打开的文件的 FD 都是从 3 开始
12. 实例12：列出目前连接主机nf5260i5-td上端口为：20，21，80相关的所有文件信息，且每隔3秒重复执行`lsof -i @nf5260i5-td:20,21,80 -r 3`