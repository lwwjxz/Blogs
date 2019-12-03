1. 分页必须带order by。      
2. 查看没有主键的所有表       
```
select b.name from sysobjects b where xtype='U' and  b.name not in   (select object_name(a.parent_obj)  from sysobjects a where xtype='PK' )

```
3. 查询所有的表、视图。      
```
use 对应的dbname
select b.name from sysobjects b where xtype='V'; //视图
select b.name from sysobjects b where xtype='U'; //用户表
select b.name from sysobjects b where xtype='S'; //系统表
```

