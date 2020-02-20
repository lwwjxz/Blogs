[参考](https://blog.csdn.net/dyzhen/article/details/6238125)      

指导出insert语句
```
mysqldump -uroot -proot2018 -t --skip-extended-insert --skip-opt --skip-comments --no-set-names --disable-keys   mdm_trans_test_1 --tables mdm_dictionary >123.sql
```
