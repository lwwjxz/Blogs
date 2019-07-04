1. 根据登录和非登陆，交互和非交互shell加载的环境变量不同。   
1. 赋值语句等号两边不能有空格。  
1. 逻辑运算  
    > 整数比较    
      ```
      -eq 等于,如:if [ "$a" -eq "$b" ]   
      -ne 不等于,如:if [ "$a" -ne "$b" ]   
      -gt 大于,如:if [ "$a" -gt "$b" ]   
      -ge 大于等于,如:if [ "$a" -ge "$b" ]   
      -lt 小于,如:if [ "$a" -lt "$b" ]   
      -le 小于等于,如:if [ "$a" -le "$b" ]   
      <   小于(需要双括号),如:(("$a" < "$b"))   
      <=  小于等于(需要双括号),如:(("$a" <= "$b"))   
      >   大于(需要双括号),如:(("$a" > "$b"))   
      >=  大于等于(需要双括号),如:(("$a" >= "$b"))   
      ```
  
   > 字符串比较   
      ```
      = 等于,如:if [ "$a" = "$b" ]   
      == 等于,如:if [ "$a" == "$b" ],与=等价 
      ```
1. exprot xxx 把xxx设置为环境变量，当前bash和子bash中都能引用到。    
2. 在变量的设置当中，单引号与双引号的用途有何不同？ 答：单引号与双引号的最大不同在于双引号仍然可以保有变量的内容，但单引号内仅能是一般字符 ，而不会有特殊符号
1. 当前shell的pid`echo $$ `
1. 上一个命令的回传值`echo ?`为0表示正常，非0表示异常。    
1. 命令搜寻顺序
   1. 以相对/绝对路径执行指令，例如“ /bin/ls ”或“ ./ls ”；
   2. 由 alias 找到该指令来执行；
   3. 由 bash 内置的 （builtin） 指令来执行；
   4. 通过 $PATH 这个变量的顺序搜寻到的第一个指令来执行。
1. 双括号运算:$((运算内容))   
1. [shell判断文件是否存在](https://www.cnblogs.com/sunyubo/archive/2011/10/17/2282047.html)   
1. [linux shell 逻辑运算符、逻辑表达式详解](https://www.cnblogs.com/chengmo/archive/2010/10/01/1839942.html)    
1. [空格](https://blog.csdn.net/zyboy2000/article/details/53940140)  
1. [空格](https://blog.csdn.net/longshenlmj/article/details/14004001)   
1. [单引号、 双引号，反引号](https://blog.csdn.net/miyatang/article/details/8077123)   
1. [十分钟学会写shell脚本](https://blog.csdn.net/l_215851356/article/details/70219330)   
