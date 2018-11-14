[AWK 简明教程](https://coolshell.cn/articles/9070.html)
其中单引号中的被大括号括着的就是awk的语句，注意，其只能被单引号包含
正则表达式示例`awk '$2>"16:11:35" && $2<"16:11:36"&& $7~/psGetAllEmployeeDtoPsGetAllEmployeeDto/ {sum+=1} END {print sum}' test.txt`  