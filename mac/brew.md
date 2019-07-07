1. 安装的过程需要编译的需要先安装xcode`  xcode-select --install`      
1. 跟换镜像命令
  ```
  # 进入brew主目录
  $ cd `brew --repo`

  # 更换镜像
  $ git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

  # 测试效果
  $ brew update
  ```
