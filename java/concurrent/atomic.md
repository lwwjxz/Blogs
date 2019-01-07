[参考](https://www.cnblogs.com/daxin/p/3366606.html)
1. compareAndSet，compare时用的是 ==,对于非基本类型比较其实就是内存地址。
1. 调用构造函数AtomicReference(V initialValue)生成对于
```
Object v = new Object();
AtomicReference<Object> atomcRefer = AtomicReference(v);
//此后将v指向别的对象比如v = new Object();对atomcRefer中的atomcRefer.value不会有影响。
//对atomcRefer.value只有调用AtomicReference的方法才会对atomcRefer.value做原子操作原子
//操作只对对象本身本身是原子性的。只要不再操作v。atomcRefer也没有保留直接操作v的成员变量的方法
//所以交给Atomic*处理的对象只要不再直接对原兑现直接进行操作就是安全的。
```
2. 