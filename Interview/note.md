# 最初级
1. 初级`==` 和 `equels` 的区别。  
1. String,StringBuffer和StringBuild的区别。    
1. 精位运算：原则是使用BigDecimal并且一定要用String来够造。   
1. 计算相关的四舍五入有问题，怎么避免。   
```
BigDecimal bg1 = new BigDecimal(0.9);  
BigDecimal bg2 = new BigDecimal(1.0);  
System.out.println(bg2.subtract(bg1));//输出0.09999999999999997779553950749686919152736663818359375  

BigDecimal bg3= new BigDecimal("0.9");  
BigDecimal bg4 = new BigDecimal("1.0");  
System.out.println(bg4.subtract(bg3));//输出0.1  
```
