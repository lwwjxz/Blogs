# [17.1 什么是 daemon 与服务 （service）](https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/148.html).     

1. daemon 就是 service。    
1. /etc/init.d中的服务是开机启动的服务。      
2. runlevel 不同启动的服务不同。      
3.从 CentOS 7.x 以后，Red Hat 系列的 distribution 放弃沿用多年的 System V 开机启动服务的流程，就是前一小节提到的 init 启动脚本的方法， 改用 `systemd 这个启动服务管理机制`。尽量用 systemd。        
4. 全部的 systemd 都用 systemctl 这个管理程序管理。    
5. systemctl 常用参数:      
```
[root@study ~]# systemctl [command] [unit]
command 主要有：
start     ：立刻启动后面接的 unit
stop      ：立刻关闭后面接的 unit
restart   ：立刻关闭后启动后面接的 unit，亦即执行 stop 再 start 的意思
reload    ：不关闭后面接的 unit 的情况下，重新载入配置文件，让设置生效
enable    ：设置下次开机时，后面接的 unit 会被启动
disable   ：设置下次开机时，后面接的 unit 不会被启动
status    ：目前后面接的这个 unit 的状态，会列出有没有正在执行、开机默认执行否、登录等信息等！
is-active ：目前有没有正在运行中
is-enable ：开机时有没有默认要启用这个 unit
```

6. 不应该使用 kill 的方式来关掉一个正常的服务喔！否则 systemctl 会无法继续监控该服务的！ 
7. 服务相关操作失败可以用`journalctl -xe`查看详情。
    
 