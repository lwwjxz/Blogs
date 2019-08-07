[参考](https://github.com/onlyliuxin/coding2017/issues/497)     
1. Socket与WebSocket处于的网络层级是不对等的，很难直接比较。WebSocket在网络七层协议上的层级等同于Http，而Socket位置处于七层协议中的第四层，
Socket是操作系统对TCP、UDP的封装。WebSocket处在上层，Socket处在下层，WebSocket依赖于Socket，Socket为WebSocket服务      
1. 感觉是因为Socket实现的是TCP，而TCP是面向stream传输的，直接用Socket容易出问题，比如粘包问题。WebSocket是一个应用层协议，更抽象，不需要考虑这些问题。所以当然可以直接用Socket实现长连接，不过仍然需要实现自己的上层协议来处理分包，比较麻烦，不如直接用WebSocket。**自己的客户端使用自己的私有协议还行，但浏览器的话更需要一个统一的应用层协议，所以WebSocket就出现了。**
1. 
