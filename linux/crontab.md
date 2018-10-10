1. 查看用户所有的crontab  `crontab [-u user] -l` 设置用户则为当前用户。     
1. 增加crontab `crontab -e` 执行该命令其实打开的vi编辑器(可以用命令修改默认的编辑器）。编辑完后会默认生效，最好加sudo这样为root的crontab权限问题会少些。     
1. 脚本中最好用绝对路径。     
1. [常用配置](https://www.jianshu.com/p/3ffc228df68c)    
1. 加到脚本时间配置后面的命令要原封不动的手工跑一遍看是否成功 比如`**/1 * * * * /data/mysql/Backup/mysqlbackup.sh` 需要手工执行`/data/mysql/Backup/mysqlbackup.sh`
而不是`sh /data/mysql/Backup/mysqlbackup.sh` 因为当文件为不可执行时前者不可执行而后者可以。     
1. 启动命令:
  ```
  /bin/systemctl restart crond.service  #启动服务

  /bin/systemctl reload  crond.service  #重新载入配置

  /bin/systemctl status  crond.service  #查看crontab服务状态
  ```    
