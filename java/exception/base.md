error和exception都集成只throwable，error不用管交给jvm处理，就像我们不用担心地球爆炸一样。error一般有栈溢出，内存不足遇到error一般该线程就会自动停掉。     

exception分为两类，一类是runtime异常和非runtime异常。    

从需不需要check的维度分为两类: uncheck 包括runtime的exception和error，check 包括非runtime 的exception     

异常都可以try catch或throws但是checked类的必须要要try catch 或throws，其实两种异常本质上没有什么区别只是sun规定一种必须要trycatch或throws      

为什么有些异常必须check:  io操作等占用系统资源的异常必须为checked异常提醒用户来处理(释放资源等)否则会引起别的异常比如一个读文件io流发生异常没有释放资源虽然当前线程结束了但是如果其他线程想要获取该文件的io流则获取不到。自己写代码很少遇到需要定义check异常的时候。   



本来异常一出现当前的执行线路（线程）就会中断，trycatch可以用让程序不中断当前执行路径（线程）继续执行。finaly的出现可以让即使该方法return和或throw异常了也可以执行finaly中的语句，但是finaly中抛出异常就要即使前面已经成功return了也会无效，如果前面已经抛出了异常的调用该方法的语句只会接受到finaly语句中抛出的异常。不管try和catch代码块发生returen还是throw只要finaly代码块中有return该方法就会正常return finaly中return的值，finaly发生throw该方法就会throw中的值，一般很好在finaly中return和throw的。   

通常， 应该捕获那些知道如何处理的异常， 而将那些不知道怎么处理的或者需要上层来处理的异常继续进行传递；    
```
try{

}catch(SQLException e){    

Throwable se = new ServletException("database error");    

se.initCause(e); //不丢失异常链可以initCause方法或者很多异常的构造函数会接受嵌套的异常方法。    

throw se;

}
```   
不要把异常链丢失。


... n more n表示所有的外层已近打印出来的调用链的个数。
```
Exception in thread "main" java.lang.RuntimeException
	at com.lww.test.exceptiontest.test.sssss(test.java:32)
	at com.lww.test.exceptiontest.test.main(test.java:16)
  at qqqqq
  at qqqqqqqq
Caused by: java.lang.RuntimeException
	at com.lww.test.exceptiontest.test.sssss(test.java:27)
	... 3 more
Caused by: java.lang.IllegalArgumentException: 1
	at com.lww.test.exceptiontest.test.sssss(test.java:25)
	... 3 more
```

NullPointerException丢失异常堆栈信息[参考](https://blog.csdn.net/taotao4/article/details/43918131)，加虚拟机参数-XX:-OmitStackTraceInFastThrow后就不会出现该问题

