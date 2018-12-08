    1. [Runnable、Callable、Future、FutureTask的区别与示例](https://blog.csdn.net/bboyfeiyu/article/details/24851847)     
1. Runable和Callable的区别是：     
      1. Callable规定的方法是call(),Runnable规定的方法是run().     
      2. Callable的任务执行后可返回值，而Runnable的任务没有返回值 .    
      3. call方法可以抛出异常，run方法不可以 .     
      4. Callable支持泛型，Runnable不支持；     
1. Future是获取结果的接口，FutureTask是RunnableFuture的实现，RunnableFuture是Runnable和Future的实现所以。FutureTask对象是父线程和子线程共享的所以FutureTask中的run方法会调用FutureTask的线程状态来实现Future接口的功能。
1. java.util.concurrent.FutureTask#get(long, java.util.concurrent.TimeUnit)方法超时不会中断正在信息的线程。      
