1. 查看java 安装路径 `/usr/libexec/java_home -V   (注意V是大写)`     
1. 查看某个版本的jdk路径 `/usr/libexec/java_home -v(小写) 1.6`  java9 版本号是9 而不是1.9    
1. 切换jdk版本
  ```
  vim ~/.bash_profile
  # java9 版本号是9 而不是1.9   
  export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
  ```
