1. 对jdk中ByteBuffer的扩展。
    1. 操作更加方便不用flip了。
    2. 为不同的使用场景开发了不同的buf,比如用于IO通讯线程的DirectByteBuf,用于
    业务消息编解码的HeapByteBuf。
    3. 基于对象池的ByteBuf可以重用ByreBuf对象，它自己维护一个内存池，可以循环利用

    