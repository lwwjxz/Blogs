1. Test double        
  dummy object (a string “John” or a constant integer 12345)        
  stub (a StubHttpResponse class that always returns the same response “OK”)       
  spy (a SpyHttpResponse class that records all invocations of the onGet method)          
  fake (a FakeDatabase class which persists to an in memory H2 database instead of an expensive production-like instance of Oracle)          
  mock (a dynamic proxy implementation of UserListener interface, implemented by Mockito and used in a unit test)          
一同出现的几个概念常见的关系是:相似，递进，互斥等。        
