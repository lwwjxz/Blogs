1. 视频教程: https://www.bilibili.com/video/BV14T4y1z7sw/?spm_id_from=333.337.search-card.all.click
2. 打包工具: 主要是将React，Vue等框架，ES6模块化语法，Less/Sass等css预处理器开发的程序编译成浏览器识别的js，css等。除此之外打包工具还能压缩代码，做兼容性处理提高性能等。
3. webpack的本身的功能是有限的
  1. 开发模式：仅能编译js的ES Module语法。  
  2. 生产模式：能编译js的ES Module语法，还能压缩js。    
4. 核心概念
    1. entry
    2. output
    3. loader webpack仅能处理js、json等功能，要处理css等资源需要借助loader   
    4. plugins
    5. mode  开发和生产
5. 配置文件只能放在根目录下，文件名只能叫webpack.config.js     
    1. entry用绝对路径
    2. output 要用绝对路径
7. . 常用命令
  1. npx webpack 入口文件  --mode-development(production)   
