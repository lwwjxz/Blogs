1. [ 安装好后登录为空白页的解决方法](https://www.cnblogs.com/yangxia-test/p/4363566.html)   
1. [配置资源中的git时选用git协议时报错`Host key verification failed`](https://stackoverflow.com/questions/15174194/jenkins-host-key-verification-failed), 选用http协议且使用用户名和密码访问时没有该问题。  
1. [参数化构建时支持git分支选择需要安装插件`Git Parameter`,同时资源管理的git-Branches to build 需要设置为`$BRANCH`](https://blog.csdn.net/u012076316/article/details/52056107)  
1. 执行mvn命令的时候需要在安装jenkins的机器上安装maven并设置好环境变量(获取环境变量可能有问题，主要是shell的登录和非登录，交互和非交互模式造成的)  
1. 在Credentials中是指密码或者私钥等。   
1. 设置ssh server配置 系统管理-》系统设置中配置。  
    >1. Source files的配置根据ant 的模式选择文件，规则  
    
        Wildcard | Description
        ---- | ---
        ？ | 匹配任何单字符
        \* |  匹配0或者任意数量的字符
        \*\* |  匹配0或者更多的目录  
    
    
    



