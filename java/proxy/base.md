1. 不管是JDK还是CGlib都是在运行期生成字节码，正因为这样才叫动态代理。
1. [JDK动态代理](https://segmentfault.com/a/1190000007089902#articleHeader8)
    1. InvocationHandler:实现代理逻辑。
    1. Proxy.newProxyInstance 生成代理对象的方法。这个肯定是调用了InvocationHandler.invoke
    1. 动态代理是类级别的而不是方法级别的。
    1. JDK代理是通过反射实现的。
    1. 由于`newProxyInstance(ClassLoader loader,Class<?>[] interfaces,InvocationHandler h)`的`interfaces`参数所以动态代理只能代理
    实现接口的类。      
2. [Java动态代理机制详解（JDK 和CGLIB，Javassist，ASM）](https://blog.csdn.net/luanlouis/article/details/24589193)
    1. ASM 是一个 Java 字节码操控框架。它能够以二进制形式修改已有类或者动态生成类。`ASM 可以直接产生二进制 class 文件，也可以在类被加载入 Java 虚拟机之前动态改变类行为`。ASM 从类文件中读入信息后，能够改变类行为，分析类信息，甚至能够根据用户要求生成新类。
    2. Javassist 只有动态的生成，而ASM可以静态的生成(编译器，或者加载近jvm之前生成)
1. CGLib是以生成子类的方法实现的，所以无法代理final方法。

1. jdk与CGLib的区别: 
    1. jdk必须有实现的接口且生成的代理类也只能代理某个类接口定义的方法。
    1. Java动态代理使用Java原生的反射API进行操作，在生成类上比较高效；CGLIB使用ASM框架直接对字节码进行操作，在类的执行过程中比较高效。
   
