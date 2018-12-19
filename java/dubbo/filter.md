1. [核心源码-Filter链原理](https://juejin.im/post/5ad40ee1f265da2375075a23)
    1. 对于Dubbo原生自带的filter，注解@Activate是必须，其group用于provider/consumer的站队，而order值是filter顺序的依据。但是对于自定义filter而言，注解@Activate没被用到，其分组和顺序，完全由用户手工配置指定。如果自定义filter添加了@Activate注解，并指定了group了，则这些自定义filter将升级为原生filter组

