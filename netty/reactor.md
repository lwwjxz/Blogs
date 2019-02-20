1. [参考](https://github.com/lwwjxz/Blogs/blob/master/netty/Java%20IO%E6%A8%A1%E5%9E%8B%E4%BB%8EBIO%E5%88%B0NIO%E5%92%8CReactor%E6%A8%A1%E5%BC%8F.md)
	1. 有图有代码特别容易理解。
1. [netty线程模型](https://www.jianshu.com/p/38b56531565d)[另一种理解方式](https://www.jianshu.com/p/1a6d1a25e6cc?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)
	1. 处理监听到selecter的IO事件和处理任务队列。
1. register0报channel注册到eventLoop().selector。   

注册。
io.netty.channel.nio.NioEventLoop#processSelectedKey(java.nio.channels.SelectionKey, io.netty.channel.nio.AbstractNioChannel)
循环线程:
io.netty.channel.nio.NioEventLoop#run

BossGroup为什么要设置成多线程的，一般情况下生成一个线程就够了。
https://stackoverflow.com/questions/34275138/why-do-we-really-need-multiple-netty-boss-threads