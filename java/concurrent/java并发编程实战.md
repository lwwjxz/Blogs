1. ThreadLocal 用于存放线程的全局变量。全部变量就是要全局很多地方使用的如果声明成局部变量通过参数传来传去也可以但是多麻烦呀，只要声明成public static 
ThreadLocal变量就可以在任何时候用了。??ThreadLocal的实现，remove方法.[参考](http://blog.xiaohansong.com/2016/08/06/ThreadLocal-memory-leak/)                
      1. 综合上面的分析，我们可以理解ThreadLocal内存泄漏的前因后果，那么怎么避免内存泄漏呢？     
      1. 每次使用完ThreadLocal，都调用它的remove()方法，清除数据。      
      1. 在使用线程池的情况下，没有及时清理ThreadLocal，不仅是内存泄漏的问题，更严重的是可能导致业务逻辑出现问题。所以，使用ThreadLocal就跟加锁完要解锁一样，用完就清理。
1. queue中不能添加null因为移除操作需要通过返回的是不是null来判断有没有移除成功。     
1. JDK5之前java线程即是工作单元也是执行机制。从JDK5开始，把工作单元与执行机制分离开来。工作单元包括Runnable和Callable，而执行机制有Executor框架提供。此处的执行机制猜测就是延时执行，定时执行，线程满了怎么办等

