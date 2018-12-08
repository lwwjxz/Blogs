[java8](https://zhuanlan.zhihu.com/p/33253953)
[java8](https://winterbe.com/posts/2014/03/16/java-8-tutorial/)
    1. 一个所谓的函数式接口必须要有且仅有一个抽象方法声明。为了让你定义的接口满足要求，你应当在接口前加上 @FunctionalInterface 注解。编译器会注意到这个注解，如果你的接口中定义了第二个抽象方法的话，编译器会抛出异常。
        1. How can Comparator be a Functional Interface when it has two abstract methods? 
            1. 如果接口重写了java.lang.Object中的方法，则不叫抽象方法，因为所有的类都是Object的子类都会默认实现这个方法。
    1. lambda表达式就是让编译器自动把lambda表达式变为编译为对应的接口实现，至于哪个接口的实现是由编译器根据上下文推导的。
    2. `(from) -> Integer.valueOf(from);`=`Integer::valueOf;` 只有静态方法才能这样。
    3. `Person::new;`
    4. Lambda的范围
        1. 对于lambda表达式外部的变量，其访问权限的粒度与匿名对象的方式非常类似。你能够访问局部对应的外部区域的局部final变量，
        以及成员变量(成员变量不是局部变量所以不会随着弹栈而消失)和静态变量。
        1. lambda是一个就是一个语法糖，会被编译为匿名内部类的。
        2. [为何在匿名内部类中只能问被final修饰的本地变量（java8 中改为等效final本地变量）？](https://www.jianshu.com/p/e310b56fd105)
            1. 当我们创建匿名内部类的那个方法调用运行完毕之后，因为局部变量的生命周期和方法的生命周期是一样的，当方法弹栈，这个局部变量就会消亡了，但内部类对象可能还存在。 此时就会出现一种情况，就是我们调用这个内部类对象去访问一个不存在的局部变量，就可能会出现空指针异常      
            2. 如果使用 final 修饰会在类加载的时候进入常量池，即使方法弹栈，常量池的常量还在，也可以继续使用，JVM 会持续维护这个引用在回调方法中的生命周期
    1. 



