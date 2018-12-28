[参考](https://blog.csdn.net/s10461/article/details/53941091)
[通配符：上边界、下边界与无界](https://blog.csdn.net/hanchao5272/article/details/79355931)
[泛型](https://segmentfault.com/a/1190000005179142)
    1. Java 的泛型使用了类型擦除机制，这个引来了很大的争议，以至于 Java 的泛型功能受到限制，只能说是”伪泛型“。什么叫类型擦除呢？简单的说就是，类型参数只存在于编译期，在运行时，Java 的虚拟机 ( JVM ) 并不知道泛型的存在。
    2. 类型擦除的补偿。
[数组泛型](https://www.zhihu.com/question/20928981)
```
// 编译不通过，跟数组的协变性没关系因为即是不是泛型协变性也是有问题的。个人认为是因为泛型编译的
// 时候会被擦除所以new Set<String>[20];中的String其实是没用的，这个数组其实是Set类的数组
// 至于声明的<String> 为什么能通过是因为编译期需要对数组的赋值给数组的内容做校验。
Set<String>[] mapArray = new Set<String>[20];

// 正确的写法
Set<String>[] mapArray = new Set[20];


```