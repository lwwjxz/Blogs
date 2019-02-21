登录脚本
```
#!/usr/bin/expect

set timeout 30
spawn ssh -p 22 root@10.19.19.295
expect {
        "(yes/no)?"
        {send "yes\n";exp_continue}
        "password:"
        {send "sdfsdfsd\n"}
}
interact
```

然后打开iTerm2的设置里，点开Profiles，左下角点+号新增一个配置文件，然后在Genernal->Command下选择 Command，在输入框里填入 expect ~/.ssh/shellname
下次打开iTerm2就可以选择你自己的配置文件，免密码登录服务器了，极大提升效率。
