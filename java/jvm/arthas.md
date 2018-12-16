1. [官方文档](https://alibaba.github.io/arthas/install-detail.html)
2. 安装
    ```
    $ wget https://alibaba.github.io/arthas/arthas-boot.jar
    $ java -jar arthas-boot.jar
    ```
3. 因为应用被trace一次后就会继续监听telnet和http端口所以需要监控别的应用的时候需要重新指定别的端口
`java -jar arthas-boot.jar --telnet-port 8013 --http-port 8014`
4. arthas默认只监听127.0.0.1，所以只能本机访问如果需要远程访问启动的时候需要带参数--target-ip 0.0.0.0。启动的时候最佳实践命令
`java -jar arthas-boot.jar <pid>  --telnet-port 8017 --http-port 8018 --target-ip 0.0.0.0`