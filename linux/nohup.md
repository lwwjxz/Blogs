1. 不加nohup也不加&:   
        1. 关闭终端进程结束
        1. 进程会接受终端的输入，并且标准输出和错误输出都会输出到终端。
2. 加&:
        1. 关闭终端进程结束。在Iterm要关闭整个Tab页，关闭Tab中的一个子窗口不行。
        2. 不接受标准输入，标准输出会输出到终端
3. nohup：
        1. 关闭终端进程不会结束。
        1. 会接受标准输入。标准输出会输出到当前目录下的nohup.out。当前目录没有权限会输出到家目录~/nohup.out。
4. nohup 和 &：
        1. 关闭终端进程不会结束。
        1. 不接受标准输入，标准输出会输出到当前目录下的nohup.out。当前目录没有权限会输出到家目录~/nohup.out。
5. 测试
        1. ls 2>1测试一下，不会报没有2文件的错误，但会输出一个空的文件1；
        2. ls xxx 2>1测试，没有xxx这个文件的错误输出到了1中；
        3. ls xxx 2>&1测试，不会生成1这个文件了，不过错误跑到标准输出了；
        4. ls xxx >out.txt 2>&1, 实际上可换成 ls xxx 1>out.txt 2>&1；重定向符号>默认是1,错误和输出都传到out.txt了。