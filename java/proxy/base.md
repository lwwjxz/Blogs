1. 不管是JDK还是CGlib都是在运行期生成字节码，正因为这样才叫动态代理。
2. [Java动态代理机制详解（JDK 和CGLIB，Javassist，ASM）]()
    1. ASM 是一个 Java 字节码操控框架。它能够以二进制形式修改已有类或者动态生成类。`ASM 可以直接产生二进制 class 文件，也可以在类被加载入 Java 虚拟机之前动态改变类行为`。ASM 从类文件中读入信息后，能够改变类行为，分析类信息，甚至能够根据用户要求生成新类。
    2. Javassist 只有动态的生成，而ASM可以静态的生成(编译器，或者加载近jvm之前生成)
1. CGLib是以生成子类的方法实现的，所以无法代理final方法。