1. equals返回true，hashcode一定相等。hashcode相等equals不一定相等，hashcode不相等equals一定为false。    
因为很多地方都是默认满足该条件的前提下作的。比如hashset中的数据不能重复的实现就是先比较hashcode没有重复的就认定没有重复了。     
hashset中原始不能重复的意思是所有的元素两两equals都不能返回true。   
hashset判断是否相等是先判断hashcode，如果不等就认为。
[参考](https://www.cnblogs.com/Qian123/p/5703507.html)      
