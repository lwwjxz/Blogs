1. 安装登录   
    >SSH分客户端openssh-client和openssh-server  
  如果你只是想登陆别的机器的SSH只需要安装openssh-client（ubuntu有默认安装，如果没有则sudo   
  apt-get install openssh-client），如果要使本机开放SSH服务就需要安装openssh-server   
  sudo apt-get install openssh-server  
  然后确认sshserver是否启动了：  
  ps -e |grep ssh     
  如果看到sshd那说明ssh-server已经启动了。  
  如果没有则可以这样启动：sudo /etc/init.d/ssh start 或者 service ssh start   
  ssh-server配置文件位于/etc/ssh/sshd_config，在这里可以定义SSH的服务端口，默认端口是22，你可以自己定义成其他端口号，如222。   
  然后重启SSH服务：   
  sudo /etc/init.d/ssh stop   
  sudo /etc/init.d/ssh start   
1. ssh默认不允许root用户登录。如果需要让root登录则需要修改配置文件 `/etc/ssh/sshd_config` ，修改PermitRootLogin的值为`PermitRootLogin no`
或者删除该配置项。   
1. ssh-keygen 基本用法   
    >`ssh-kengen`必须在~/.ssh下执行， `ssh-kengen` 会在`~/.ssh/`目录下生成两个文件，不指定文件名和密钥类型的时候，默认生成的两个文件是：  
    `id_rsa`   
    `id_rsa.pub`   
    第一个是私钥文件，第二个是公钥文件。   
    生成ssh key的时候，可以通过 -f 选项指定生成文件的文件名，如下:    
    `ssh-keygen -f filename   -C "注释"`不设置filename为默认名字`id_rsa`和`id_rsa.pub`    
    如果生成中要设置密码每次使用的时候都需要密码(没实践过)   
    [使用 SSH config 文件](http://daemon369.github.io/ssh/2015/03/21/using-ssh-config-file)   
    
1. 
    
    

    

