1. SystemProperties jvm的系统变量，可以用java -D设置。
2. SystemEnvironment 操作系统的环境变量。   
3. PropertyResolver.getProperty() 的优先级是SystemProperties->SystemEnvironment