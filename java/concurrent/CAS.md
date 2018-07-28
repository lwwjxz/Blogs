1. [参考](http://zl198751.iteye.com/blog/1848575)      
1. CAS可能存在ABA问题，就是一个值从A变成了B又变成了A，使用CAS操作不能发现这个值发生变化了，处理方式是可以使用携带类似时间戳的版本AtomicStampedReference
[参考](https://liuzhengyang.github.io/2017/05/11/cas/)    
1. CAS是乐观的，锁时悲观的。    
