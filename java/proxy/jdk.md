1. 所有调用最终都走到了java.lang.reflect.InvocationHandler#invoke(Object proxy, Method method, Object[] args)
    1. proxy为最后生成的代理对象实例。
    2. method为被代理对象对应的方法。
    3. args为method的参数。
1. JDK的动态代理只能代理那些实现接口的类。