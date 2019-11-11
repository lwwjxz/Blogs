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

使用 Alibaba 的 Homebrew 镜像源进行加速
```
cd "$(brew --repo)"
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git

echo $SHELL

zsh 终端操作方式

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc

echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.bash_profile
source ~/.bash_profile


```
