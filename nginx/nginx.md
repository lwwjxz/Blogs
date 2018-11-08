1. nginx 是多进程的，`ps -ef | grep nginx` 能出来好多结果。其中主进程的备注信息为 master process。kill 该进程即可。如果配置文件里设置了pid则主进程的pid
会存在该文件中 `kill  'pid文件的位置'`     
1. 平滑启动和平滑升级。   
1. 测试语法错误：`nginx -t -c 配置文件路径`    
1. 是一个web服务器。也可用于反向代理。[proxy_pass](https://blog.csdn.net/zhongzh86/article/details/70173174)       
1. [Nginx实现虚拟主机和反向代理](https://my.oschina.net/rosetta/blog/745197)       
    1. 虚拟主机意思就是把一台主机虚拟成几台。        
    2. 反向代理是代理其他主机对外提供请求，当然同一台机器上也行。    
1. 使修改的配置生效:/usr/local/nginx/sbin -r reload   
2. [nginx的location配置详解](https://blog.csdn.net/tjcyjd/article/details/50897959)只看语法规则部分就行了，其他部分比较乱没看懂。 
3. 遇到403错误应该是权限的问题修改nginx.conf中user为user  root;      