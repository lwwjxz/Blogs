# 最初级
1. 初级`==` 和 `equels` 的区别。  
1. String,StringBuffer和StringBuild的区别。   
1. 精位运算：原则是使用BigDecimal并且一定要用String来够造。   
1. 银行家舍入发收入和支出方之间结算的时候有用。    
1. 分账的时候就收最后一个参与者收到的钱是总数-其他参与者的总和，避免 `20 / 3 = 6.67 , 6.67*3=20.01>20`的问题。   
1. Object.toString() 方法@后面是什么意思。  
1. hashcode()  和 equals() 方法：   
    1. 如果两个对象根据equals方法比较是相等的，那么调用两个对象的hashCode方法必须返回相同的整数结果。  
    1. 如果两个对象根据equals方法比较是不等的，则hashCode方法不一定得返回不同的整数。
    1. 设计hashCode()时最重要的因素就是：无论何时，对同一个对象调用hashCode()都应该产生同样的值。如果在讲一个对象用put()添加进HashMap时产生一个hashCdoe值，而用get()取出时却产生了另一个hashCode值，那么就无法获取该对象了。所以如果你的hashCode方法依赖于对象中易变的数据，用户就要当心了，因为此数据发生变化时，hashCode()方法就会生成一个不同的散列码。  
    
```
BigDecimal bg1 = new BigDecimal(0.9);  
BigDecimal bg2 = new BigDecimal(1.0);  
System.out.println(bg2.subtract(bg1));//输出0.09999999999999997779553950749686919152736663818359375  

BigDecimal bg3= new BigDecimal("0.9");  
BigDecimal bg4 = new BigDecimal("1.0");  
System.out.println(bg4.subtract(bg3));//输出0.1  
```    
1. java 集合框架   
    1. Set和List的区别。   
    1. ArraryList和LinkedList的区别。
    1. `for(int i = 0 ;i<list.size();i++)和 foreach(Integer i:List<Integer>)`的区别   
    1. list的过滤和分组。   
    1. HashMap的数据结构。容量，hash因子默认值，hash因子的作用 [参考](https://bestswifter.com/hashtable/)。     
    1. 
