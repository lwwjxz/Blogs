[参考](https://www.aneasystone.com/)      
1. RC级别保证所有已经读的值不会改变(不会出现脏读)，所以要锁住已经读过的值。
2. [innodb引擎中insert是串行的](https://stackoverflow.com/questions/32087233/how-does-mysql-handle-concurrent-inserts)。
3. 当设置为自动提交时执行完`··· for update`事务自动提交，提交后就会释放锁，所以如果想锁住数据需要先`start transaction;`
设置为不自动提交，然后再执行`··· for update`。
