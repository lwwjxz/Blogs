# rpm    
1. 查看系统有没有自带jdk。     
    ```
    rpm -qa |grep java

    rpm -qa |grep jdk

    rpm -qa |grep gcj
    
    java -version
    ```      
1. 如果有安装则卸载    
   `如果安装可以使用rpm -qa | grep java | xargs rpm -e --nodeps 批量卸载所有带有Java的文件  这句命令的关键字是java`  
# [不按照直接解压](https://www.cnblogs.com/stulzq/p/9286878.html)  

# 用yum安装

1. 下载orcle的java rpm文件。     
    `wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm`
  
1. 安装     
    `sudo yum localinstall jdk-8u102-linux-x64.rpm`     
1. 设置环境变量     
    ```
    # Get the aliases and functions
    if [ -f ~/.bashrc ]; then
      . ~/.bashrc
    fi

    # User specific environment and startup programs

    export JAVA_HOME=/usr/java/jdk1.8.0_102/
    export JRE_HOME=/usr/java/jdk1.8.0_102/jre

    PATH=$PATH:$HOME/bin:$JAVA_HOME/bin

    export PATH
    
    ```
