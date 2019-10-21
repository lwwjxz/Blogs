1. [为什么需要主动关闭文件](https://mrdear.cn/2018/08/04/java/Java--why_close_file/)        
    1. linux中一切皆文件,网络连接也是，所以socketinputstream继承自fileinputstream       
    1. 文件在java中对应的类为FileDescriptor。      
    1. 大多数情况下finalize()会关闭资源但是finalize()什么时候运行不确定。      
1. [未关闭的文件流会引起内存泄露么](https://juejin.im/entry/5cfd1537518825765939e067)       
1. [try-with-resource](http://www.kissyu.org/2016/10/06/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3Java%20try-with-resource/)     
    1. 实现资源必须实现AutoClosable接口。      
    1. 实现原理其实是编译器会自动在finaly中关闭流。      
