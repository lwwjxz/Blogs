1. [仓库地址](https://hub.docker.com/r/jenkins/jenkins/)   
2. 安装命令:  
    ```sh
    docker pull jenkins/jenkins    
    docker run jenkins/jenkins     
    #生成本地目录
    mkdir ~/jenkins_home  
    #挂载本地目录 一定要加-d 设置成守护进程 端口映射要手工设置  
    docker run -d -v ~/jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins   
    ```
