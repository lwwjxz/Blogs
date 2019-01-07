1. netty取消对AIO的支持，因为增加了复杂度但是没有提高性能。
2. 绑定端口: sun.nio.ch.Net#bind0
3. io.netty.channel.ChannelOption#SO_BACKLOG 存放没有被accept的连接的队列的数量，队列分为两个一个是三次握手结束的，
一个是正在三次握手的。

    