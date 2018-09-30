1. [官网参考yum源地址](https://downloads.mariadb.org/mariadb/repositories/#mirror=evowise-ny&distro=CentOS)    
1. 新建repo文件，并插入版本对应的源信息   `vi /etc/yum.repos.d/MariaDB.repo`      
1. ` yum -y install MariaDB-server MariaDB-client`      
1. ```
systemctl start mariadb #启动服务
systemctl enable mariadb #设置开机启动
systemctl restart mariadb #重新启动
systemctl stop mariadb.service #停止MariaDB
````

