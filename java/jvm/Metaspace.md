1. 为什么jdk用去掉了永久带加入了metaspace?
   1. 永久带启动时固定大小很难调优，FullGC时会移动类元信息影响性能。   
   1. 动态加载类过多会引起OOM,`“εxception in thread 'dubbo client x.x connector' java.lang.OutO阳 emoryE口or: PennGen space"`   
   1. metaspace的空间大小如果不手动设置则没有限制，直到机器的物理内存耗尽才会OOM。   
   1. 原永久带的内存中字符串常量值移至堆内其他包括类原信息，字段，静态属性，常量等都移至metaspace    
