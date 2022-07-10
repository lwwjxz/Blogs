[参考](https://www.jianshu.com/p/7a04f28b08a6)    
1. Test double(测试替身)             
    1. dummy object pass around but never actually used]        
        1. Dummy Object对象是指为了调用被测试方法而传入的假参数，为什么说是假参数呢？实际上这些传入的Dummy对象并不会对测试有任何作用，仅仅是为了成功调用被测试方法。所以，Dummy Object又被称为Dummy parameter或placeholder。
    2.  stub [ you can define answers to me; I'll respond the same]     
    3.  mock [you can set your expectation on me]    
    4.  fake [you can have me with limited capabilities] 
        1. Fake Object可以是一个“fake DB”比如简单的内存数据库来代替真实的重量级的数据库，也可以是一个“fake web service”比如创建一个简单的web service来返回指定的response。
    5.  spy [monitor real ones; you can change my behavior]
        1. mock方法和spy方法都可以对对象进行mock。但是前者是接管了对象的全部方法，而后者只是将有桩实现（stubbing）的调用进行mock，其余方法仍然是实际调用。   
        2. java中
            1. when(...) thenReturn(...)做了真实调用。只是返回了指定的结果    
            2. doReturn(...) when(...)    

2. 一同出现的几个概念常见的关系是:相似，递进，互斥等。        
