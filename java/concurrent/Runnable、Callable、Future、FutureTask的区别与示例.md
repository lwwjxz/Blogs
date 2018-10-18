1. [Runnable、Callable、Future、FutureTask的区别与示例](https://blog.csdn.net/bboyfeiyu/article/details/24851847)     
1. Runable和Callable的区别是：     
      1. Callable规定的方法是call(),Runnable规定的方法是run().     
      2. Callable的任务执行后可返回值，而Runnable的任务没有返回值 .    
      3. call方法可以抛出异常，run方法不可以 .     
      4. Callable支持泛型，Runnable不支持；     
