[参考](https://www.aneasystone.com/)      
1. RC级别保证所有已经读的值不会改变(不会出现脏读)，所以要锁住已经读过的值。
2. [innodb引擎中insert是串行的](https://stackoverflow.com/questions/32087233/how-does-mysql-handle-concurrent-inserts)。
3. 