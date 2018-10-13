1. 安装前端自动化测试包`npm install nightmare`。    
1. 安装支持node命令接受参数的包`npm yargs`。   
1. 代码 shot.js    
    ```
    var nightmare = require('nightmare')()
    var argv = require('yargs').argv;
    nightmare
      .goto(argv.url)
      .wait(5000)
      .screenshot(argv.dest)
      .end()
      .then(function (result) {
          return ("Screenshot Done");
      })
      .catch(function (error) {
          console.error(error);
      });
    ```    
 1. 物理机执行命令`node shot.js --url="http://www.baidu.com" --dest=test.png` url加双引号支持参数拼接。如果是虚拟机则在最前面加`xvfb-run`       
