1. 方法一
    1. `yum install wqy-zenhei-fonts`     
    1. 建立字体缓存      
    ```
    # mkfontscale （如果提示 mkfontscale: command not found，需自行安装 # yum install mkfontscal）
    # mkfontdir 
    # fc-cache -fv （如果提示 fc-cache: command not found，则需要安装# yum install fontconfig ）
    ```
2. 方法二centos7
    1. yum -y install fontconfig    
    2. 进入 /usr/share 可以看到 fontconfig、fonts目录生成    
    3. 拷贝需要的字体   
    4. 将所需的字体上传的到Linux环境的 /usr/share/fonts/chinese目录    
    5. 安装ttmkfdir来搜索目录中所有的字体信息，并汇总生成fonts.scale文件    
      1. yum -y install ttmkfdir       
      2. ttmkfdir -e /usr/share/X11/fonts/encodings/encodings.dir      
    6. vi /etc/fonts/fonts.conf      
      ![](https://raw.githubusercontent.com/lwwjxz/Blogs/master/image/398224-20190116101241268-211988764.png)
    7. 刷新内存中的字体缓存，这样就不用reboot重启了
      1. fc-cache     
      2. fc-list看一下字体列表    
