1. [使用java命令运行class文件提示“错误：找不到或无法加载主类“的问题分析](http://www.cnblogs.com/wangxiaoha/p/6293340.html)

```
public class GetHot {
    public static void main(String[] args) {
        for(int i = 0;i < 8;i++) {
           new Thread(()->{
               while (true) {
               }
           }).start();
        }
    }
}
```
