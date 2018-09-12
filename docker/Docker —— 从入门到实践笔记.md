1. [原文](https://legacy.gitbook.com/book/yeasy/docker_practice/details)     
    1. [如果你以 scratch 为基础镜像的话，意味着你不以任何镜像为基础，接下来所写的指令将作为镜像第一层开始存在。不以任何系统为基础，直接将可执行文件复制进镜像的做法并不罕见，比如 swarm、coreos/etcd。对于 Linux 下静态编译的程序来说，并不需要有操作系统提供运行时支持，所需的一切库都已经在可执行文件里了，因此直接 FROM scratch 会让镜像体积更加小巧。使用 Go 语言 开发的应用很多会使用这种方式来制作镜像，这也是为什么有人认为 Go 是特别适合容器微服务架构的语言的原因之一](https://yeasy.gitbooks.io/docker_practice/content/image/build.html)    
    1. [理解构建上下文对于镜像构建是很重要的，避免犯一些不应该的错误。比如有些初学者在发现 COPY /opt/xxxx /app 不工作后，于是干脆将 Dockerfile 放到了硬盘根目录去构建，结果发现 docker build 执行后，在发送一个几十 GB 的东西，极为缓慢而且很容易构建失败。那是因为这种做法是在让 docker build 打包整个硬盘，这显然是使用错误](https://yeasy.gitbooks.io/docker_practice/content/image/build.html)     
    1. [因此在 COPY 和 ADD 指令中选择的时候，可以遵循这样的原则，所有的文件复制均使用 COPY 指令，仅在需要自动解压缩的场合使用 ADD。](https://yeasy.gitbooks.io/docker_practice/content/image/dockerfile/add.html)      
        1. add 还有其他的一些附加功能比如add一个url但是最好不要，可以run curl 去下载。     
    1. [Docker 不是虚拟机，容器中的应用都应该以前台执行，而不是像虚拟机、物理机里面那样，用 upstart/systemd 去启动后台服务，容器内没有后台服务的概念。](https://yeasy.gitbooks.io/docker_practice/content/image/dockerfile/cmd.html)     
    1. [对于数据库类需要保存动态数据的应用，其数据库文件应该保存于卷(volume)中](https://yeasy.gitbooks.io/docker_practice/content/image/dockerfile/volume.html)     
    1. [第一个-p 32777:5000 ，是映射本机所有网卡IP地址的32777到容器web2中的5000 ,第二个-p 192.168.2.75:32778:5000 是映射指定网卡IP192.168.2.75的32778端口到web容器中的5000端口。](http://www.111cn.net/sys/linux/120174.htm)    
    1. [Docker Machine 是什么？](https://www.cnblogs.com/sparkdev/p/7044950.html)      
    1. docker client负责server端发布请求，生成镜像，运行容器等都是在server端运行的[参考](https://www.cnblogs.com/SzeCheng/p/6822905.html)。    
    1. [Swarm是Docker官方提供的一款集群管理工具，其主要作用是把若干台Docker主机抽象为一个整体，并且通过一个入口统一管理这些Docker主机上的各种Docker资源。Swarm和Kubernetes比较类似，但是更加轻，具有的功能也较kubernetes更少一些。](https://www.cnblogs.com/franknihao/p/8490416.html)     
    1. 
