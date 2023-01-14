一句话总结：重写equals的类必须重新hashCode,且要保证两个对象equals时，hashCode必须相等。否则基于Object.hashCode的很多运行会出问题。
同一个市里的人肯定是同一个省的，同一个省的不一定是同一个市的。不是同一个省的肯定不是同一个市的。 市比省跟更精确。 equals比hashCode更精确，但是比较的时候有hashCode方法更高效，因为hashCode不相等肯定不相等。而hashCode性能比equas高。



1. [参考](https://stackoverflow.com/questions/2265503/why-do-i-need-to-override-the-equals-and-hashcode-methods-in-java)    
Joshua Bloch says on Effective Java :    You must override hashCode() in every class that overrides equals(). Failure to do so will result in a violation of the general contract for Object.hashCode(), which will prevent your class from functioning properly in conjunction with all hash-based collections, including HashMap, HashSet, and Hashtable
您必须在覆盖 equals() 的每个类中覆盖 hashCode()。不这样做将导致违反 Object.hashCode() 的一般约定，这将阻止您的类与所有基于哈希的集合（包括 HashMap、HashSet 和 Hashtable）一起正常运行。     
重写的事时候必须满足两个equals的对象hashCode必须相等, 否则该类的对象跟基于hash的集合一起使用的时候将会出现问题。比如在hashMap中key是不允许重复的，如果出现上述情况则会出现key是重复的情况





2. [参考](https://www.cnblogs.com/skywang12345/p/3324958.html)只看第一部分就好了，其他部分好像有点问题。   


