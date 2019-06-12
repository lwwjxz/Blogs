1. clone分为浅拷贝和深拷贝。
  1. 浅拷贝是指只复制了当前对象应用对象的引用。
  2. 深拷贝是指复制了当前对应所有能直接间接引用到的对象。
1. 深拷贝的实现方法：
  1. 重写所有直接合间接应用的clone方法。[如](https://blog.csdn.net/zhangjg_blog/article/details/18369201)
  2. 通过序列化实现[如](https://blog.csdn.net/caoxiaohong1005/article/details/78704890)
