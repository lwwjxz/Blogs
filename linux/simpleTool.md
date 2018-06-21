1.  日期格式化  
```
[root@root ~]# date "+%Y-%m-%d"    
2013-02-19    
[root@root ~]# date "+%H:%M:%S"    
13:13:59    
[root@root ~]# date "+%Y-%m-%d %H:%M:%S"  
2013-02-19 13:14:19  
[root@root ~]# date "+%Y_%m_%d %H:%M:%S"    
2013_02_19 13:14:58  
[root@root ~]# date -d today   
Tue Feb 19 13:10:38 CST 2013  
[root@root ~]# date -d now  
Tue Feb 19 13:10:43 CST 2013  
[root@root ~]# date -d tomorrow  
Wed Feb 20 13:11:06 CST 2013  
[root@root ~]# date -d yesterday  
Mon Feb 18 13:11:58 CST 2013 
```
