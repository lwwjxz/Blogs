# BeanDefinition
## getBeanClassName 获取bean对应的class名称
## getConstructorArgumentValues 获取构成函数入参  
## getDependsOn 获取依赖的bean，一般用在一个bean没有通过属性或者构造函数参数显式依赖另外一个bean，但实际上会使用到那个bean或者那个bean产生的某些结果的情况。 比如观察者模式中观察者要观察时间源init方法中的事件。
## getParentName 获取父BeanDefinition名称   
## getDestroyMethodName 获取destroy方法   
## getFactoryBeanName 获取FactoryBean的名称    
## getFactoryMethodName 获取FactoryMethod的名称   
## getInitMethodName 获取init的名称    
## getOriginatingBeanDefinition 遍历originator链以找到用户定义的原始 BeanDefinition。(代理生成的beanDefinition调用该方法能获取原始的beanDefinition)   
## getPropertyValues 返回要应用于 bean 的新实例的属性值。返回的实例可以在 bean 工厂后处理期间进行修改。    
## getResolvableType 根据 bean 类或其他特定元数据，返回此 bean 定义的可解析类型。这通常在运行时合并的 bean 定义上用到。     
## getRole ROLE_APPLICATION:用户定义的bean，ROLE_INFRASTRUCTURE:spring内部bean，ROLE_SUPPORT:某些复杂的bean。  
## getScope 获取scope   
## hasConstructorArgumentValues 判断是否有初始构造函数入参   
## hasPropertyValues 判断是否有初始属性值    
## isAbstract 判断bean对应的是否抽象类    
## isAutowireCandidate 是否允许被自动装配    
## isPrimary  自动装配有多个符合条件的bean时是否是主bean   
## isLazyInit 是否懒加载 beanFactory默然懒加载，applicationContext默认非懒加载   
## isPrototype scope是否Prototype    
## isSingleton scope是否Singleton    