1. [centos7安装zabbix-agent](https://www.zabbix.com/documentation/4.0/manual/installation/install_from_packages/rhel_centos)
    1. `sudo yum install zabbix-agent`
    1. 修改配置文件        /etc/zabbix/zabbix_agentd.conf
        ```
        PidFile=/var/run/zabbix/zabbix_agentd.pid
        LogFile=/var/log/zabbix/zabbix_agentd.log
        LogFileSize=0
        Server=10.111.24.48 # 服务器ip 如果设置为纯被动模式，则应该注释掉这一条指令。跟zabbixServer在同一台机器上需要设置为127.0.0.1不能设置成实际IP因为
        StartAgents=0    设置为0表示关闭被动模式 ,被动主动是agent视角的被动主动，agent主动发数据到server就为主动相反则为被动。
        ServerActive=10.111.24.48 # 主动模式的server IP地址
        Hostname=10.111.24.48 # 客户端的hostname，不配置则使用主机名。
        EnableRemoteCommands=1 #很多教程生都写成EnableRemoteCommand少一个s
        LogRemoteCommands=1
        Include=/etc/zabbix/zabbix_agentd.d/*.conf
        ```
    1. `sudo service zabbix-agent start`

1. [配置和查看](http://blog.51cto.com/solin/1846775)
1. 安装中遇到的问题:
    1. `Cannot bind socket` [解决方案](https://linotes.imliloli.com/virtualization/zabbix.basic/)
    ```
    sudo cat /var/log/audit/audit.log | grep zabbix_server | grep denied | audit2allow -M zabbix_server.limits
    ******************** IMPORTANT ***********************
    To make this policy package active, execute:

    semodule -i zabbix_server.limits.pp

    会生成两个文件：zabbix_server.limits.pp 和 zabbix_server.limits.te
    sudo semodule -i zabbix_server.limits.pp
    audit2allow 不是命令解决方案 yum install setroubleshoot
    ```
    1. `No space left on device`[解决方案](https://cloud.tencent.com/developer/article/1141169)
    ```
    [root@qiniu zabbix]# vim /etc/sysctl.conf 
    # sysctl settings are defined through files in
    # /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
    #
    # Vendors settings live in /usr/lib/sysctl.d/.
    # To override a whole file, create a new file with the same in
    # /etc/sysctl.d/ and put new settings there. To override
    # only specific settings, add a file with a lexically later
    # name in /etc/sysctl.d/ and put new settings there.
    #
    # For more information, see sysctl.conf(5) and sysctl.d(5).
    fs.file-max=65535
    kernel.sem = 500  64000  64  256  //kernel.sem这个可以根据需求在适当的调大一些。
    [root@qiniu zabbix]# sysctl -p  //使之设置生效
    ```
1. [监控jvm需要安装zabbix-java-gateway](https://blog.51cto.com/zengestudy/1789425?source=drt)
    卸载了openjdk后好像起不来了，要重新用yum -y install zabbix-java-gateway 安装才能重启，yum -y remove zabbix-java-gateway


2. 测试场景下server直接通过docker安装`docker run -e PHP_TZ=Asia/Shanghai --name xxx -p 80:80 -p 10051:10051 -d zabbix/zabbix-appliance`
1. [zabbixServer 安装](https://www.zabbix.com/documentation/4.0/zh/manual/installation/install_from_packages/rhel_centos)
    1. 其中安装好根据该教材安装php页面会默认安装的。
    2. php操作页面报错"DB连接不上"，需要执行命令`setsebool -P httpd_can_network_connect=1`;
    3. DB用户需要有DDL权限。
