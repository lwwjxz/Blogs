1. [centos7安装zabbix-agent](https://www.zabbix.com/documentation/4.0/manual/installation/install_from_packages/rhel_centos)
    1. `sudo yum install zabbix-agent`
    1. `sudo service zabbix-agent start`
    1. 修改配置文件
        ```
        /etc/zabbix/zabbix_agentd.conf

        PidFile=/var/run/zabbix/zabbix_agentd.pid
        LogFile=/var/log/zabbix/zabbix_agentd.log
        LogFileSize=0
        Server=10.111.24.48 # 服务器ip
        ServerActive=10.111.24.48 # 服务器ip
        Hostname=hostname # 一般写为本机ip
        EnableRemoteCommands=1 #很多教程生都写成EnableRemoteCommand少一个s
        LogRemoteCommands=1
        Include=/etc/zabbix/zabbix_agentd.d/*.conf
        ```
1. [配置和查看](http://blog.51cto.com/solin/1846775)