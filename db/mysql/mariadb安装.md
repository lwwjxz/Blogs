1. [官网参考yum源地址](https://downloads.mariadb.org/mariadb/repositories/#mirror=evowise-ny&distro=CentOS)    
1. 新建repo文件，并插入版本对应的源信息   `vi /etc/yum.repos.d/MariaDB.repo`      
1. ` yum -y install MariaDB-server MariaDB-client`      
1. 
```
systemctl start mariadb #启动服务
systemctl enable mariadb #设置开机启动   
systemctl disable mariadb #关闭开机启动
systemctl restart mariadb #重新启动
systemctl stop mariadb.service #停止MariaDB
```

虽然是sudo 命令起的但是进程所具有的权限才是mysql用户的 
查看命令: `ps -ax -o ruid -o euid -o suid -o fuid -o pid -o fname `   根据uid查看用户信息`getent passwd uid`      
docker 不能允许以上命令。可以允许mysqld。    
mysql默认拒绝用户使用root账户启动，因为拥有文件权限的用户可能导致MySQL Server使用root帐户创建文件（比如，~root/.bashrc），但root用户可以通过在命令后面加上"--user=root"选项来强行启动mysqld。


1. 用mysql -uroot命令登录到MariaDB，此时root账户的密码为空。     
1. 使用mysql_secure_installation命令进行配。有密码输密码，没密码直接回车。      
    > 这应该是安全设置的初始化,按照提示一步一步来就好了。     
1. 配置MariaDB的字符集
    1. 查看/etc/my.cnf文件内容，其中包含一句!includedir /etc/my.cnf.d 说明在该配置文件中引入q 目录下的配置文件。    
    1. 使用vi server.cnf命令编辑server.cnf文件，在[mysqld]标签下添加       
    
    ```
    init_connect='SET collation_connection = utf8_unicode_ci' 
    init_connect='SET NAMES utf8' 
    character-set-server=utf8 
    collation-server=utf8_unicode_ci 
    skip-character-set-client-handshake
    ```
    如果/etc/my.cnf.d 目录下无server.cnf文件，则直接在/etc/my.cnf文件的[mysqld]标签下添加以上内容。    
    1.  用vi  client.cnf命令编辑/etc/my.cnf.d/client.cnf文件，在[client]标签下添加     
    :
    ```
    default-character-set=utf8
    ```    
    
    1. 用vi  mysql-clients.cnf命令编辑/etc/my.cnf.d/mysql-clients.cnf文件，在[mysql]标签下添加     
    
    ```
    default-character-set=utf8

    ```
    
    1. 配置完成后 systemctl restart mariadb 重启服务。进入到数据库查看字符设置。    
    
    ```
    show variables like "%character%";
    show variables like "%collation%";
    ```

