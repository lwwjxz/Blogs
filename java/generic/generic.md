[维基百科](https://zh.wikipedia.org/wiki/%E6%B3%9B%E5%9E%8B)    
    包含类型参数的类型。泛型的参数只能代表类，不能代表个别对象。     
    一些强类型程序语言支持泛型，其主要目的是在不完全破坏类型安全(类型安全的定义见下文)的情况下及减少类转换的次数，但一些支持泛型的程序语言只能达到部分目的。    
    类型安全的定义:类型安全就是说，同一段内存，在不同的地方，会被强制要求使用相同的办法来解释（interpret）.     


[参考](https://blog.csdn.net/s10461/article/details/53941091)     
    此处’？’是类型实参，而不是类型形参，此处的？和Number、String、Integer一样都是一种实际的类型，可以把？看成所有类型的父类。是一种真实的类型。   
    判断是不是泛型方法的根据是类型参数是不是定义在方法上。    

  
    
[通配符：上边界、下边界与无界](https://blog.csdn.net/hanchao5272/article/details/79355931)      
    <T>：泛型标识符，用于泛型定义（类、接口、方法等）时，可以想象成形参。     
    <?>：通配符，用于泛型实例化时，可以想象成实参。      
    上边界和下边界巧记:把类的继承关系想象成自上而下Object在最上面，所以 ? extend xxx 中xxx就是上边界。 ? super xxx 中 xxx就是下边界。 
    ```
    List<? super Programmer> programmerLowerList = null;
    programmerLowerList = new ArrayList<Worker>();
    //上边界和下边界确定的是 List<? super Programmer> 的引用是否能指向new ArrayList<Worker>()。
    ```

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
