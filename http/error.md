1. 场景 `Status Code:200` 但是有失败信息 `Failure: Premature EOF encountered` 开错误的意思是提前遇到了EOF文件结束标志，经观察body中的数据
不完整提前结束了，最好发现是nginx所在的机器磁盘满了，清理了部分文件后好了修复了错误。  
