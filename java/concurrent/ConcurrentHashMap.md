1. [参考](https://blog.csdn.net/justloveyou_/article/details/72783008)   
1. size方法返回的数量有可能不准确，因为它是所有的segment中的count相加得到的结果，而在加的过程中没有对count加锁。   
