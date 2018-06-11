[参考资料1](https://www.zhihu.com/people/yang-shuai-83-7/answers)  
[参考资料2](http://www.imooc.com/u/2245641/articles?page=2)   
1. 多系统共享session的，多个系统需要需要共享，要改变原来的系统(入侵性较大)，难度比较大，比如系统是异构的。则需要改造原来的系统，且多个系统共同维护一个session肯定非常痛苦，所以就需要用全局回话和局部回话来解决这个问题了各自管好自己的session。   
1. OAuth用到的场景只是适用于用户授权的情况下访问用户第三方的数据，或者作为用户在自己系统的用户唯一标识。[参考](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)
