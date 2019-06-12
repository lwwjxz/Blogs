1. 数组都是特殊的类代码自动生成的类，父类都是Object。

```

        Object[] objects = new Object[1];
        System.out.println(objects.getClass());//class [Ljava.lang.Object;
        System.out.println(objects.getClass().getSuperclass());//class java.lang.Object
        String[] strings = new String[1];
        System.out.println(strings.getClass());//class [Ljava.lang.String;
        System.out.println(strings.getClass().getSuperclass());//class java.lang.Object
        int[] ints = new int[1];
        System.out.println(ints.getClass());//class [I
        System.out.println(ints.getClass().getSuperclass());//class java.lang.Object
        double[] doubles = new double[1];
        System.out.println(doubles.getClass());//class [D
        System.out.println(doubles.getClass().getSuperclass());//class java.lang.Object
```

1. 同一个类只生成一个class

```
        String[] strings = new String[1];
        String[] strings1 = new String[1];
        System.out.println(strings.getClass());//class [Ljava.lang.String;
        System.out.println(strings1.getClass());//class [Ljava.lang.String;
        System.out.println(strings.getClass()==strings1.getClass());//true
```
