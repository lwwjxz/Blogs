1. [Dapper 论文](https://bigbully.github.io/Dapper-translation/)   
1. zabbix之类的工具是对机器的监控颗粒度比较粗，而APM是对应用的监控。       
1. APM Application Performance Management 应用性能监控。       
1. [APM相关开源工具](https://www.zhihu.com/question/27994350)       
    1. 推荐的顺序依次是Pinpoint—》Zipkin—》CAT     
        >原因很简单，就是这三个工具对于程序源代码和配置文件的侵入性，是依次递增的：Pinpoint：基本不用修改源码和配置文件，
        只要在启动命令里指定javaagent参数即可，对于运维人员来讲最为方便；Zipkin：需要对Spring、web.xml之类的配置文件做修改，
        相对麻烦一些；CAT：因为需要修改源码设置埋点，因此基本不太可能由运维人员单独完成，而必须由开发人员的深度参与了，
        而很多开发人员是比较抗拒在代码中加入这些东西滴；
        相对于传统的监控软件（Zabbix之流）的区别，APM跟关注在对于系统内部执行、系统间调用的性能瓶颈分析，
        这样更有利于定位到问题的具体原因，而不仅仅像传统监控软件一样只提供一些零散的监控点和指标，就算告警了也不知道问题是出在哪里。     
1. [APM工具性能比较]()https://juejin.im/post/5a7a9e0af265da4e914b46f1。     
