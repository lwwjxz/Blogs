1.  a 和 b 指向同一个对象，所以a和b是同一个锁。c 和 d是不同的的对象。   
```
Integer a = 1;
Integer b = 1;

Integer c = new Integer(1);
Integer d = new Integer(1);
```
