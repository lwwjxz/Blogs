1. [IO 多路复用是什么意思,点赞回答](https://www.zhihu.com/question/32163005)   
    1. select
        1. select会修改传入的参数数组(不太理解)  
        1. select 如果任何一个sock(I/O stream)出现了数据，select 仅仅会返回，但是并不会告诉你是那个sock上有数据，于是你只能自己一个一个的找，10几个sock可能还好，要是几万的sock每次都找一遍，这个无谓的开销就颇有海天盛筵的豪气了。
        1. select 只能监视1024个链接， 这个跟草榴没啥关系哦，linux 定义在头文件中的，参见FD_SETSIZE。  
        1. select 不是线程安全的，如果你把一个sock加入到select, 然后突然另外一个线程发现，尼玛，这个sock不用，要收回。对不起，这个select 不支持的，如果你丧心病狂的竟然关掉这个sock, select的标准行为是。。呃。。不可预测的， 这个可是写在文档中的哦.
    1. poll   
        poll 去掉了1024个链接的限制，于是要多少链接呢， 主人你开心就好。
        poll 从设计上来说，不再修改传入数组，不过这个要看你的平台了，所以行走江湖，还是小心为妙。
    1. epoll  
        1. epoll 现在是线程安全的。    
        1. epoll 现在不仅告诉你sock组里面数据，还会告诉你具体哪个sock有数据，你不用自己去找了。   
    1. 性能高测试   
    ![](https://github.com/lwwjxz/Blogs/blob/master/image/5a56c4677da1c10153ed22a3f6dfeab4_hd.png)     
    横轴Dead connections 就是链接数的意思，叫这个名字只是它的测试工具叫deadcon. 纵轴是每秒处理请求的数量，你可以看到，epoll每秒处理请求的数量基本     不会随着链接变多而下降的。poll 和/dev/poll 就很惨了。    
    `可是epoll 有个致命的缺点。。只有linux支持。比如BSD上面对应的实现是kqueue。`
