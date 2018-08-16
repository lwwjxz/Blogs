1. nginx 是多进程的，`ps -ef | grep nginx` 能出来好多结果。其中主进程的备注信息为 master process。kill 该进程即可。如果配置文件里设置了pid则主进程的pid
会存在该文件中 `kill  'pid文件的位置'`     
1. 平滑启动和平滑升级。   
1. 测试语法错误：`nginx -t -c 配置文件路径`    
1. 本事是一个web服务器。也可用于反向代理。[proxy_pass](https://blog.csdn.net/zhongzh86/article/details/70173174)       

