1. node是Chrome V8 引擎的 JavaScript 运行时的环境。所以现在浏览器里的js大部分都是在node运行时环境中运行的。node相当于java的虚拟机。    
2. jquery 和 react(node 框架，比如java中的spring)的区别    
![image](https://user-images.githubusercontent.com/12959356/196990611-50a7839e-0afe-4472-964e-27da67edd915.png)    
3. npm 缓存https://juejin.cn/post/6984062167339237389      
4. npm 路径查找https://juejin.cn/post/7146953567398526983     
https://juejin.cn/post/6984062167339237389      
5. node 原生模块: C++开发的模块https://www.techug.com/post/nodejs-n-api/      
6. 版本管理    
```
n是nodejs的一个模块，作者是TJ Holowaychuk，node下非常有名的express框架的作者，看它的名字就知道，它的理念就是简单

安装： sudo npm install -g n，使用n --version查看是否安装成功
**配置：无需配置
n常用命令说明
n 列出你本地安装过的node版本，可以通过上下方向键选择你需要的版本，按enter或者方向右键确认,前面有个圆圈的表示你当前正在使用的版本 icon
n ls 列出服务器上可以安装的所有版本
n <version> 安装指定版本node
n rm <version> 删除指定版本的Node
n stable 安装最新稳定版本
n latest 安装最新版本
n use <version> [args ...] 使用指定版本的node执行js文件
更多的命令，请使用n help查看
nvm和n的区别
n比nvm更简单，n的口号，**"no subshells, no profile setup, no convoluted api, just simple"**
n没有nvm的繁琐配置
nvm是使用shell脚本编写的
最后，推荐大家使用更简单的n，可以少折腾
```
7. n的原理: 
将/usr/local/bin/node可执行文件和跟node版本相关的各种文件替换一遍。     
10. node项目的级别目录结构: https://www.cnblogs.com/licurry/p/6719513.html
