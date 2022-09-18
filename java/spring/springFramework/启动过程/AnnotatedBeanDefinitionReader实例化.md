# AnnotatedBeanDefinitionReader 实例化   
## setDependencyComparator 设置排序器    
## setAutowireCandidateResolver 设置自动装配解析器   
## 注册ConfigurationClassPostProcessor的BeanDifinition  实现了BeanFactoryPostProcessor，处理@Configuration，@ComponmentScan等注解   
## 注册AutowiredAnnotationBeanPostProcessor的BeanDifinition 实现了BeanPostProcessor，处理@Autowired，@Value等    
## 注册CommonAnnotationBeanPostProcessor的BeanDifinition 实现了BeanPostProcessor，用来处理JSR-250规范的注解，如@Resource，@PostConstruct等   
## 注册PersistenceAnnotationBeanPostProcessor的BeanDifinition 实现了BeanFactoryPostProcessor，用来支持JPA
## 注册EventListenerMethodProcessor的BeanDifinition（实现了BeanFactoryPostProcessor 用来对 @EventListener 提供支持.主要是标注了 @EventListener 的方法进行解析, 然后转换为一个 ApplicationListener.）  
## 注册DefaultEventListenerFactory的BeanDifinition  作用就是支持@EventListener注解的，EventListenerMethodProcessor在创建ApplicationListener的时候需要DefaultEventListenerFactory来进行创建