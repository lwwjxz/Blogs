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
5. 配置文件只能放在根目录下，文件名只能叫webpack.config.js：配置文件解释官网: https://webpack.docschina.org/configuration/     
6. webpack默认输出文件都在dist没有分目录，想分目录可以配置。   
7. webpack 打包不会删除上次打包的内容，可以配置
8. 代码格式处理 ESlint
9. webpack 只能编译ES6的模块化语法，其他的像箭头函数之类的ES6语法没有处理，会导致IE等浏览器无法解析。这就需要babel来处理  
10. 发布生产环境
  1. 生产和开发用不同的配置文件。   
  2. npx webpack serve --config ./配置文件位置
  3. npx webpack --config ./配置文件位置    生产模式下只打包不需要启动server。
11. 默认情况下css会被打包到js里边，网络不好的时候可能出现闪屏现象，原因是浏览器会先解析html再加载js然后在解析css，所以需要把css单独打包成单独的文件然后通过link标签直接写到html页面。对应插件 MiniCssExtractPlgin。

12. . 常用命令
  1. npx webpack 入口文件  --mode-development(production)   
  2. 安装开发服务器 npm i webpack-dev-server -D   
  3. npx webpack serve 启动项目服务器，开发服务器不会把编译后的文件输出到dist，而是保存在内存中。

13. loader和plugins 区别:   
While loaders are used to transform certain types of modules, plugins can be leveraged to perform a wider range of tasks like bundle optimization, asset management and injection of environment variables.相对于loader转换指定类型的模块功能，plugins能够被用于执行更广泛的任务比如打包优化、文件管理、环境注入等

14. 高级
  1. SourceMap: 代码报错后提示源代码中的行数       
  2. OneOf: 打包时每个文件都会经过所有的load处理，虽然因为有test的正则实际没匹配的就不会处理但是都要过一遍。也会拖慢速度。    
  3. Include/Exclude:开发时用到的第三方库或插件。Include、Exclude互斥的只能二选一     
  4. Cache: 每次打包成js都要经过EsLint检查和Babel编译，速度比较慢。可以用Cache实现每次只检查和编译修改过的文件。   
  5. Thread: 多线程打包。非常大的项目打包设置以小时为单位的。但是小项目不需要，因为线程启动也是需要时间的。        
  6. Tree Shaking: 摇树把不用的代码摇下来，依赖ES module，CommonJs不行。    
  7. plugin-transform-runtime: 禁用Babel自动对每个文件runtime注入。而是引入plugin-transform-runtime并使所有辅助代码从这里引用。   
  8. image minimizer: 图片压缩
  9. code split: webpack会默认将所有js打包成一个文件。加载会很慢，可以分割成多个按需加载。   
  10. preLoad:默认预加载   preFetch:空闲时预加载，  预加载是在code split的基础上的。
  11. corejs，虽然babel解决了大部分兼容性问题，但是遇到低版本的浏览器还是不够，用corejs可以彻底解决问题。    
  12. PWA:  通过service-worker.js

