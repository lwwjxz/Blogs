1. [从PAXOS到ZOOKEEPER分布式一致性原理与实践.pdf](https://github.com/double-qiu/books/blob/master/%E4%BB%8EPAXOS%E5%88%B0ZOOKEEPER%E5%88%86%E5%B8%83%E5%BC%8F%E4%B8%80%E8%87%B4%E6%80%A7%E5%8E%9F%E7%90%86%E4%B8%8E%E5%AE%9E%E8%B7%B5.pdf)         
    1. zk不适合做服务注册中心，因为zk是通过牺牲可用性保证一致性的，比如网络分区后节点数量小于整个集群一半分区将不可用，其实不可用分区上也有服务的注册信息只不过分区后不会再更新了，所以只对网络分区后下线或者发布的服务的调用有影响。     
