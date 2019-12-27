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
4. 查看所有触发器 。          
```
SELECT   name, is_instead_of_trigger FROM  sys.triggers  WHERE  type = 'TR'
```

5. 查看表结构
```
SELECT
c.name as columnName,
a.VALUE as columnDescript
FROM
sys.extended_properties a,
sysobjects b,
sys.columns c
WHERE
a.major_id = b.id
AND c.object_id = b.id
AND c.column_id = a.minor_id
AND b.name = 'TableName';
```
