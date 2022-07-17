[参考](https://www.baeldung.com/mockito-vs-easymock-vs-jmockit)      
# Mockito
1. @Mock creates a mock. @InjectMocks creates an instance of the class and injects the mocks that are created with the @Mock (or @Spy) annotations into this instance.
# EasyMock
1. 跟mockIto比不支持spy。     
# JMockit
1. 可以mock静态方法。    
# powerMockito    
1. PowerMock基本上cover了所有Mockito不能支持的case（大多数情况也就是静态方法，但其实也可以支持私有方法和构造函数的调用）  
2. 与mockito的版本匹配https://github.com/powermock/powermock/wiki/Mockito  
3. 私有方法 https://www.jianshu.com/p/aaa1743da768


# 测试覆盖率的统计相关问题
1. https://blog.csdn.net/yezhixinghuo/article/details/109552795
