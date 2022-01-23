JIT的全称是Just in time compilation，中文称之为即时编译。JIT是JVM最强大的武器之一，在运行时可以让java从屌丝到高富帅的飞跃，强大到在google上搜索为什么java比c++快居然会有200W的结果。    
#### 通常JIT的有以下几种手段来优化JVM的性能
  1. 针对特定CPU型号的编译优化，JVM会利用不同CPU支持的SIMD指令集来编译热点代码，提升性能。像intel支持的SSE2指令集在特定情况下可以提升近40倍的性能。   
  2. 减少查表次数。比如调用Object.equals()方法，如果运行时发现一直是String对象的equals，编译后的代码可以直接调用String.equals方法，跳过查找该调用哪个方法的步骤。      
  3. 逃逸分析。JAVA变量默认是分配在主存的堆上，但是如果方法中的变量未逃出使用的生命周期，不会被外部方法或者线程引用，可以考虑在栈上分配内存，减少GC压力。另外逃逸分析可以实现锁优化等提升性能方法。
  4. 寄存器分配，部分变量可以分配在寄存器中，相对于主存读取，更大的提升读取性能。
  5. 针对热点代码编译好的机器码进行缓存。代码缓存具有固定的大小，并且一旦它被填满，JVM 则不能再编译更多的代码。
  6.方法内联，也是JIT实现的非常有用的优化能力，同时是**开发者能够简单参与JIT性能调优的地方**。   
#### 方法内联是什么。为什么它能够提升性能
要搞清楚为什么方法内联有用，首先要知道当一个函数被调用的时候发生了什么     
  1. 首先会有个栈，存储目前所有活跃的方法，以及它们的本地变量和参数
  2. 当一个新的方法被调用了，一个新的栈帧会被加到栈顶，分配的本地变量和参数会存储在这个栈帧
  3. 跳到目标方法代码执行
  4. 方法返回的时候，本地方法和参数会被销毁，栈顶被移除
  5. 返回原来地址执行    
因此，函数调用需要有一定的时间开销和空间开销，当一个方法体不大，但又频繁被调用时，这个时间和空间开销会相对变得很大，变得非常不划算，同时降低了程序的性能。方法内联就是把被调用方函数代码"复制"到
调用方函数中，来减少因函数调用开销的技术     
  被内联前的代码
```java
private int add4(int x1, int x2, int x3, int x4) { 
    return add2(x1, x2) + add2(x3, x4); 
}

private int add2(int x1, int x2) {  
    return x1 + x2;  
}
```
运行一段时间后，代码被内联翻译成    
```java
private int add4(int x1, int x2, int x3, int x4) { 
    return x1 + x2 + x3 + x4; 
}
```
JVM会自动的识别热点方法，并对它们使用方法内联优化。那么一段代码需要执行多少次才会触发JIT优化呢？通常这个值由-XX:CompileThreshold参数进行设置：   
   1. 使用client编译器时，默认为1500；   
   2. 使用server编译器时，默认为10000；    
但是一个方法就算被JVM标注成为热点方法，JVM仍然不一定会对它做方法内联优化。其中有个比较常见的原因就是这个方法体太大了，分为两种情况。   
   1. 如果方法是经常执行的，默认情况下，方法大小小于325字节的都会进行内联（可以通过` -XX:MaxFreqInlineSize=N`来设置这个大小）
   2. 如果方法不是经常执行的，默认情况下，方法大小小于35字节才会进行内联（可以通过` -XX:MaxInlineSize=N `来设置这个大小）   
我们可以通过增加这个大小，以便更多的方法可以进行内联；但是除非能够显著提升性能，否则不推荐修改这个参数。因为更大的方法体会导致代码内存占用更多，更少的热点方法会被缓存，最终的效果不一定好。    
如果想要知道方法被内联的情况，可以使用下面的JVM参数来配置
```shell
-XX:+PrintCompilation: Prints out when JIT compilation happens
-XX:+UnlockDiagnosticVMOptions: Is needed to use flags like -XX:+PrintInlining
-XX:+PrintInlining: Prints what methods were inlined
```
#### Netty库上使用内联优化的例子
issue： https://github.com/netty/netty/issues/1812

NioMessageUnsafe是Netty常用的读取Socket channel，处理readbuf方法。
```java
private final class NioMessageUnsafe extends AbstractNioUnsafe {
        ...

        @Override
        public void read() {
            assert eventLoop().inEventLoop();
            final SelectionKey key = selectionKey();
            if (!config().isAutoRead()) {
                int interestOps = key.interestOps();
                if ((interestOps & readInterestOp) != 0) {
                    // only remove readInterestOp if needed
                    key.interestOps(interestOps & ~readInterestOp);
                }
            }

            final ChannelConfig config = config();
            final int maxMessagesPerRead = config.getMaxMessagesPerRead();
            final boolean autoRead = config.isAutoRead();
            final ChannelPipeline pipeline = pipeline();
            boolean closed = false;
            Throwable exception = null;
            try {
                for (;;) {
                    int localRead = doReadMessages(readBuf);
                    if (localRead == 0) {
                        break;
                    }
                    if (localRead < 0) {
                        closed = true;
                        break;
                    }

                    if (readBuf.size() >= maxMessagesPerRead | !autoRead) {
                        break;
                    }
                }
            } catch (Throwable t) {
                exception = t;
            }

            int size = readBuf.size();
            for (int i = 0; i < size; i ++) {
                pipeline.fireChannelRead(readBuf.get(i));
            }
            readBuf.clear();
            pipeline.fireChannelReadComplete();

            if (exception != null) {
                if (exception instanceof IOException) {
                    // ServerChannel should not be closed even on IOException because it can often continue
                    // accepting incoming connections. (e.g. too many open files)
                    closed = !(AbstractNioMessageChannel.this instanceof ServerChannel);
                }

                pipeline.fireExceptionCaught(exception);
            }

            if (closed) {
                if (isOpen()) {
                    close(voidPromise());
                }
            }
        }
        ...
    }
```
使用netty的官方HTTP sever [hello work例子](https://github.com/netty/netty/tree/4.1/example/src/main/java/io/netty/example/http/helloworld)，启动的时候加入jit分析参数

```shell
-XX:+PrintCompilation -XX:+UnlockDiagnosticVMOptions -XX:+PrintInlining 
```
并对其做了一段时间压测后    
```log
 66527  370             io.netty.channel.nio.NioEventLoop::processSelectedKeysOptimized (80 bytes)
                        @ 14   java.nio.channels.SelectionKey::attachment (5 bytes)   inline (hot)
           !            @ 33   io.netty.channel.nio.NioEventLoop::processSelectedKey (120 bytes)   inline (hot)
                          @ 1   io.netty.channel.nio.AbstractNioChannel::unsafe (8 bytes)   inline (hot)
                            @ 1   io.netty.channel.AbstractChannel::unsafe (5 bytes)   inline (hot)
                          @ 6   java.nio.channels.spi.AbstractSelectionKey::isValid (5 bytes)   inline (hot)
                          @ 26   sun.nio.ch.SelectionKeyImpl::readyOps (9 bytes)   inline (hot)
                            @ 1   sun.nio.ch.SelectionKeyImpl::ensureValid (16 bytes)   inline (hot)
                              @ 1   java.nio.channels.spi.AbstractSelectionKey::isValid (5 bytes)   inline (hot)
           !              @ 42   io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe::read (191 bytes)   inline (hot)
           !              @ 42   io.netty.channel.nio.AbstractNioMessageChannel$NioMessageUnsafe::read (327 bytes)   hot method too big
                            @ 4   io.netty.channel.socket.nio.NioSocketChannel::config (5 bytes)   inline (hot)
                              @ 1   io.netty.channel.socket.nio.NioSocketChannel::config (5 bytes)   inline (hot)
                            @ 12   io.netty.channel.AbstractChannel::pipeline (5 bytes)   inline (hot)
                            @ 17   io.netty.channel.DefaultChannelConfig::getAllocator (5 bytes)   inline (hot)
                            @ 24   io.netty.channel.DefaultChannelConfig::getMaxMessagesPerRead (5 bytes)   inline (hot)
                            @ 44   io.netty.channel.DefaultChannelConfig::getRecvByteBufAllocator (5 bytes)   inline (hot)
                            @ 49   io.netty.channel.AdaptiveRecvByteBufAllocator::newHandle (20 bytes)   executed < MinInlining Threshold times
```

NioMessageUnsafe.read方法体因为过大无法被inline优化。当对read方法进行简单拆分，减少每个方法体大小之后, 简化代码如下   
```
 private final class NioMessageUnsafe extends AbstractNioUnsafe {
        ...

        private void removeReadOp() {
            SelectionKey key = selectionKey();
            int interestOps = key.interestOps();
            if ((interestOps & readInterestOp) != 0) {
                // only remove readInterestOp if needed
                key.interestOps(interestOps & ~readInterestOp);
            }
        }
    
        @Override
        public void read() {
            assert eventLoop().inEventLoop();
            if (!config().isAutoRead()) {
                removeReadOp();
            }

            final ChannelConfig config = config();
            ...
        }
        ...
    }
   
```

再次压测后的日志,NioMessageUnsafe.read方法被顺利加入内联优化。

```
               !              @ 42   io.netty.channel.nio.AbstractNioMessageChannel$NioMessageUnsafe::read (288 bytes)   inline (hot)
```
#### 方法内联的条件
虽然JIT号称可以针对代码全局的运行情况而优化，但是JIT对一个方法内联之后，还是可能因为方法被继承，导致需要类型检查而没有达到性能的效果        
想要对热点的方法使用上内联的优化方法，最好尽量使用final、private、static这些修饰符修饰方法，避免方法因为继承，导致需要额外的类型检查，而出现效果不好情况。

#### 结论
热点方法的内联优化建议   
1. 更小的方法体
2. 尽量使用final、private、static修饰符
3. 使用+PrintInlining参数校验效果

