1. 新建数据库'CREATE DATABASE `newdb` DEFAULT CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;'    
2. 拷贝`mysqldump test -u root -ppassword --add-drop-table --no-data | sed 's/ AUTO_INCREMENT=[0-9]*\b//' | mysql test_2 -u root -ppassword`
    1. sed ··· 替换AUTO_INCREMENT的值。       
    1. --no-data 不拷贝数据       
    1. --add-drop-table 新增表之前先删除。       
