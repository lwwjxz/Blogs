1. maven生命周期的各个阶段默认绑定的插件和目标，没有声明绑定的时候插件能不能默认绑定，[参考](http://www.cnblogs.com/tannerBG/p/4235410.html):   
    > 具体不知道绑定到哪个阶段可以查看pom文件的effective pom，如果pom中没有设置绑定阶段但是插件有默认绑定阶段，或者在pluginManagement中设置了绑定阶段那么effective会显示最终的绑定结果。
