1. !q 退出后按任意键会重新就让vim编辑界面。q!会放弃保存修改内容直接退出     
1. 快捷键
```
h               光标左移
l               光标右移
A               移动光标到当前行尾，并进入 insert 状态
0               移动光标到当前行首
i               在当前位置进入 insert 状态
a               在当前位置后进入 insert 状态
dd              删除当前行
D               删除光标之后的内容
p               粘贴刚删除的文本
u               撤销历史操作
ctrl+r          搜索历史命令
!!              执行上条命令
ctrl+X Ctrl+E   调用默认编辑器去编辑一个特别长的命令
```
1. [替换](https://blog.csdn.net/shuangde800/article/details/10554513)
2. 全局删除匹配到的行`:g/pattern/d`
3. 删除第1-10行里的匹配到的行`:1,10g/pattern/d`
4. 删除匹配不到的行`:g!/pattern/d`
