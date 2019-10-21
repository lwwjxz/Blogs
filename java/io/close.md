1. [为什么需要主动关闭文件](https://mrdear.cn/2018/08/04/java/Java--why_close_file/)        
    1. linux中一切皆文件,网络连接也是，所以socketinputstream继承自fileinputstream       
    1. 文件在java中对应的类为FileDescriptor。      
    1. 大多数情况下finalize()会关闭资源但是finalize()什么时候运行不确定。      
1. [未关闭的文件流会引起内存泄露么](https://juejin.im/entry/5cfd1537518825765939e067)       
