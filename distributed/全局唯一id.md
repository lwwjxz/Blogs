1. [UUID](https://www.zhihu.com/question/34876910/answer/88924223)   
    1. UUID有多种算法，不同的算法重复的概率不一样。 重复的概率极低.
    1. 无法保证趋势递增。可以控制ShardingId。比如某一个用户的文章要放在同一个分片内，这样查询效率高，修改也容易。
    1. 太长，没有趋势递增所以作为索引来说效率太低。   
1. []https://www.cnblogs.com/baiwa/p/5318432.html
