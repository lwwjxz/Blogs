1. 查看接口/类的继承关系    
   1. 光标选中对应的接口/类 Shift+option+command+U     
   2. 在图中选中对应的接口/类 option+command+B 选中要显示的类类回车即可，可以按shift多选    
2. debug插件源码    
   将插件源码加入lib即可      
   ```Go to "Project Structure" > "Libraries" > "+" > "Java" and add the path of the Jar.```

3. find Useage jar中的代码，必须啊先download source。   
4. idea 配置自动下载源码
   ```File => Setting => Build, Execution, Deployment => Build Tools => Maven => Importing 然后勾选自动下载 Sources，Documentation即可```
5. 代码检查 
   ```Analyze => inpectCode ```
   结果出来后可以设置要检查的项
   ![image](https://user-images.githubusercontent.com/12959356/194757755-a4e2c089-35ec-496d-bebd-0712e0a7a607.png)
6. 方法的调用链，```control + option + H```

7. 源码乱码问题解决插件 https://github.com/YangZhengkuan/auto.transform.encoding/blob/master/README.md
