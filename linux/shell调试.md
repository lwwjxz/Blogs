1. `bash -x xxx.sh` 如果xxx.sh中执行的脚本yyy.sh则需要
用`bash -x yyy.sh`的方式执行才能使yyy.sh也显示调试信息。
要显示文件名行号等可以在shell中执行`export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '`只在当前
窗口中有效，也可以加载xxx.sh中。https://coolshell.cn/articles/1379.html
1. vs code也可以调试。具体需要用到的时候再研究。
1. bashdb虽然功能强大但是资料少，所以暂且不研究。
1. [bashdb下载](https://sourceforge.net/projects/bashdb/files/) 根据shell类型和版本下载对应的版本
    1. 安装的时候要提权`sudo -i`
2. [linux脚本调试-bashdb安装及调试](https://my.oschina.net/huhaoren/blog/1545297)
    1. `bashdb --debug 脚本名`
