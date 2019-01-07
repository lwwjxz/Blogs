1. inputstream是抽象类而不是接口。
1. BufferedInputStream会把所有的数据存放在buffer中所以支持mark和reset，但是buffer有容量限制。
2. reader的读取是用StreamDecoder,StreamDecoder可以解码。
2. ByteArrayInputStream从byte数组读数据。
3. DataInputStream，在一直类型的情况下把多个byte转化为相应的数据。
4. 操作系统读取的都是以byte为单位的。
5. RandomAccessFile的绝大多数功能，但不是全部，已经被JDK 1.4的nio的"内存映射文件(memory-mapped files)"给取代了，你该考虑一下是不是用"内存映射文件"来代替RandomAccessFile了。
    1. [getFilePoint()](https://blog.csdn.net/qq496013218/article/details/69397380)
    2. [seek(long pos)](https://blog.csdn.net/qq496013218/article/details/69397380)
    3. [demo](https://blog.csdn.net/akon_vm/article/details/7429245)
