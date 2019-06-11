1. 数组都是特殊的类代码自动生成的类，父类都是Object。

```

        Object[] objects = new Object[1];
        System.out.println(objects.getClass());//class [Ljava.lang.Object;
        System.out.println(objects.getClass().getSuperclass());//class java.lang.Object
        String[] strings = new String[1];
        System.out.println(strings.getClass());//class [Ljava.lang.String;
        System.out.println(strings.getClass().getSuperclass());//class java.lang.Object
```

