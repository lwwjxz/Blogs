1. [参考](https://github.com/onlyliuxin/coding2017/issues/497)     
Socket与WebSocket处于的网络层级是不对等的，很难直接比较。WebSocket在网络七层协议上的层级等同于Http，而Socket位置处于七层协议中的第四层，
Socket是操作系统对TCP、UDP的封装。WebSocket处在上层，Socket处在下层，WebSocket依赖于Socket，Socket为WebSocket服务
