1. [https://github.com/lwwjxz/javacore/blob/master/docs/basics/java-generic.md][泛型] ，看第一条就够了下面都是重复的。  
    类型边界和类型通配符是不同的东西没有可比性，不能因为他们格式有点像就老纠结这两纠结他们有啥不一样。就像在问是桌子好还是凳子好。
    1.0优点    
       1.0.1 编译时的强类型检查，保证了类型安全。     
       1.0.2 避免了类型转换，给没使用泛型时相比。      
    
    1.1 类型边界
     ```
     public static class TestExtends<T extends Serializable>{}
     ```
    上面代码中<T extends Serializable>是形参限制实例化泛型时参数类型只能是Serializable的子类    
    ```
        static <T extends Comparable<T>> T max(T x, T y, T z) {
        T max = x; // 假设x是初始最大值
        if (y.compareTo(max) > 0) {
            max = y; //y 更大
        }
        if (z.compareTo(max) > 0) {
            max = z; // 现在 z 更大
        }
        return max; // 返回最大对象
    }

    ```
    上面代码`Comparable<T>`中有T表示没T好像一样的，先不纠结    
  
    ```
    public final class Integer extends Number implements Comparable<Integer> {
    ```
    上面代码中声明Integer类的时候`Comparable<Integer>`中用到了Integer，证明Integer和其他类没两用。老想先有蛋还是先有鸡的问题，其实这个收
    
    1.2 类型通配符是实参     
    List<? extends Number> list  list只能接受参数类型是Number子类的List类型的实例    
    List<? super Integer> list list只能接受参数类型是Integer父类的List类型的实例    
    
















2. [维基百科](https://zh.wikipedia.org/wiki/%E6%B3%9B%E5%9E%8B)    
    参数化类型
    包含类型参数的类型。泛型的参数只能代表类，不能代表个别对象。     
    一些强类型程序语言支持泛型，其主要目的是在不破坏类型安全的情况下及减少类转换的次数前提下复用代码如Java中的list如果没有泛型或者设置基本缘分为object或者每一种类型都需要自定义相关的list，但一些支持泛型的程序语言只能达到部分目的。    
    类型安全的定义:类型安全就是说，同一段内存，在不同的地方，会被强制要求使用相同的办法来解释（interpret）.     


3. [参考](https://blog.csdn.net/s10461/article/details/53941091)     
    此处’？’是类型实参，而不是类型形参，此处的？和Number、String、Integer一样都是一种实际的类型，可以把？看成所有类型的父类。是一种真实的类型。   
    判断是不是泛型方法的根据是类型参数是不是定义在方法上。    

  
    
4. [通配符：上边界、下边界与无界](https://blog.csdn.net/hanchao5272/article/details/79355931)      
    \<T\>:泛型标识符，用于泛型定义（类、接口、方法等）时，可以想象成形参。     
    <?>：通配符，用于泛型实例化时，可以想象成实参。      
    上边界和下边界巧记:把类的继承关系想象成自上而下Object在最上面，所以 ? extend xxx 中xxx就是上边界。 ? super xxx 中 xxx就是下边界。 


    ```
    List<? super Programmer> programmerLowerList = null;
    programmerLowerList = new ArrayList<Worker>();
    //上边界和下边界确定的是 List<? super Programmer> 的引用是否能指向new ArrayList<Worker>()。
    
    ```
    
    上边界类型通配符（<? extends 父类型>）：因为可以确定父类型，所以可以以父类型去获取数据（向上转型）。但是不能写入数据。     
    下边界类型通配符（<? super 子类型>）：因为可以确定最小类型，所以可以以最小类型去写入数据（向上转型）。而不能获取数据。     
    无边界类型通配符（<?>） 等同于 上边界通配符<? extends Object>，所以可以以Object类去获取数据，但意义不大。      



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
