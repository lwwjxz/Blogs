1. [参考](https://blog.csdn.net/briblue/article/details/54973413)      
    1. ClassLoader的parent创建时指定，不知道默认为AppClassLoader。      
    1. BootstrapClassLoader可以是其他类加载器逻辑上的父类，但是其他的classloader.getParent()不可能得到BootstrapClassLoader。如果逻辑
    上的父类为BootstrapClassLoader的getParent()只能得到null。    
    1. java中的核心类库加载器为BootstrapClassLoader，比如 int.class 但是int.class.getCloassLoader()结果为null。     
1. [打破双亲加载模型](https://blog.csdn.net/wangyangzhizhou/article/details/51787377)      
