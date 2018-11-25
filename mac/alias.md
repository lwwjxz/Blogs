1. alias显示所有的别名。
2. unalias取消别名只在当前shell中有效。
3. 永久有效需要改配置文件:
    1. 修改.bash_profile或.zshrc文件，格式`alias [别名]='[指令名称]'`
    2. 立即生效:`source ~/.bash_profile,source ~/.zshrc`