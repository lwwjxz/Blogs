1. [select、poll、epoll](https://www.jianshu.com/p/dfd940e7fca2)      
    1. select连接数有限制(1024虽然可以通过编译内核的方法修改)，对描述符采用线性扫描，性能较低。
    1. poll除了连接数没有限制以外跟select差不多。
    1. epoll连接数上限有内存确定1G内存大约能监听10万个端口。不是线性扫描而是回调的方式性能更改。
