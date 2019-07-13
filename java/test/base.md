1. 测试工具: testng比junit好用功能丰富。
1. mock数据能简化单元测试，比如要调用第三方的接口，或访问数据库等，如果不能mock还要去第三方的系统或者数据库去造数据效率太低了，而且不可复用(数据可能被别人删除或修改)
1. PowerMock则在Mockito原有的基础上做了扩展，通过修改类字节码并使用自定义ClassLoader加载运行的方式来实现mock静态方法、final方法、private方法、系统类的功能
1. [类覆盖率，方法覆盖率，分支覆盖率，条件判断覆盖率](https://www.zhihu.com/tardis/sogou/art/55648107?ab_signature=CiRBT0NoZ3R5NnlRNUxCUVpGbWt4N0lMd2xkM1F6OWVXRi10MD0SIGYwODBiYmVjMzAwNTBlMmIyYWY2MDcwOTAzNjk2YWMyGg8IARIFNi4zLjAaBDEzNDA=&utm_source=wechat_session&utm_medium=social&utm_oi=736257005617958912)   
