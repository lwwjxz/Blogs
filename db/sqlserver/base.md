1. 分页必须带order by。
2. 查看没有主键的所有表
```
select b.name from sysobjects b where xtype='U' and  b.name not in   (select object_name(a.parent_obj)  from sysobjects a where xtype='PK' )

```
