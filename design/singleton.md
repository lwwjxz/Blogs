1. [单例模式的七种写法](http://www.hollischuang.com/archives/205)
1. [由于类的初始化是线程安全的所以可以基于类的初始还来解决线程安全的问题。(私有静态内部类)](https://www.infoq.cn/article/double-checked-locking-with-delay-initialization)
2. 双重检查锁定，注意实例一定要是volatile的，否则重排序会导致线程安全问题。
3. 反射可以破坏单例模式，因为反射可以调用private方法
4. [单例与序列化的那些事儿](https://www.hollischuang.com/archives/1144) 增加readResolve方法。
5. [抵御clone攻击](https://zhuanlan.zhihu.com/p/28491630) 重写clone方法。
6. [枚举序列化和反序列化没有问题](https://www.hollischuang.com/archives/2498)。