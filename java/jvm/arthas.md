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
    1. 这里的`0.0.0.0`表示绑定监听本机ip而不是127.0.0.1。
1. 远程登录 
    1. `telnet ip --telnet-port`  
    2. `webconsole`:不过webconsole需要现在本机启动然后访问http://127.0.0.1:8563/ 再填入ip和--http-port。
1. 本机退出后如何进入：`telnet 127.0.0.1 --telnet-port`   

1. 使用场景
    1. 这个类从哪个 jar 包加载的？为什么会报各种类相关的 Exception？
    1. 我改的代码为什么没有执行到？难道是我没 commit？分支搞错了？
    1. 遇到问题无法在线上 debug，难道只能通过加日志再重新发布吗？
    1.  线上遇到某个用户的数据处理有问题，但线上同样无法 debug，线下无法重现！
    1. 是否有一个全局视角来查看系统的运行状况？
    1. 有什么办法可以监控到JVM的实时运行状态？
    1. 运行时修改类

