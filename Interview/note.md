# 最初级
1. 初级`==` 和 `equels` 的区别。  
1. String,StringBuffer和StringBuild的区别。    
1. 精位运算：原则是使用BigDecimal并且一定要用String来够造。   
1. 银行家舍入发收入和支出方之间结算的时候有用。
1. 分账的时候就收最后一个参与者收到的钱是总数-其他参与者的总和，避免 `20 / 3 = 6.67 , 6.67*3=20.01>20`的问题。   
```
BigDecimal bg1 = new BigDecimal(0.9);  
BigDecimal bg2 = new BigDecimal(1.0);  
System.out.println(bg2.subtract(bg1));//输出0.09999999999999997779553950749686919152736663818359375  

BigDecimal bg3= new BigDecimal("0.9");  
BigDecimal bg4 = new BigDecimal("1.0");  
System.out.println(bg4.subtract(bg3));//输出0.1  
```
