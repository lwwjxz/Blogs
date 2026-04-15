#!/bin/bash

# ============================================================================
#  Mac 开发环境全面检查脚本
#  适用于长期使用、安装过大量工具的 Mac 电脑
# ============================================================================

set +e  # 不因命令失败而退出，兼容各种环境

# --- timeout 兼容 ---
# macOS 自带没有 timeout 命令，需要兼容处理
if ! command -v timeout &>/dev/null; then
    timeout() {
        local duration=$1; shift
        perl -e "alarm $duration; exec @ARGV" "$@" 2>/dev/null
    }
fi

# --- 颜色定义 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

divider() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${CYAN}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

section() {
    echo ""
    echo -e "  ${YELLOW}▸ $1${NC}"
}

info() {
    echo -e "    ${GREEN}✔${NC} $1"
}

warn() {
    echo -e "    ${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "    ${RED}✘${NC} $1"
}

dim() {
    echo -e "    ${DIM}$1${NC}"
}

cmd_exists() {
    command -v "$1" &>/dev/null
}

# ============================================================================
#  1. 系统基本信息
# ============================================================================
divider "系统基本信息"

info "主机名:        $(scutil --get ComputerName 2>/dev/null || hostname)"
info "macOS 版本:     $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
info "内核版本:       $(uname -r)"
info "芯片架构:       $(uname -m)"

if [[ "$(uname -m)" == "arm64" ]]; then
    if pgrep -q oahd; then
        info "Rosetta 2:      已安装且运行中"
    elif [ -f /Library/Apple/usr/share/rosetta/rosetta ]; then
        info "Rosetta 2:      已安装"
    else
        dim "Rosetta 2:      未安装"
    fi
fi

info "系统运行时间:   $(uptime | sed 's/.*up //' | sed 's/,.*//')"
info "当前用户:       $(whoami)"
info "Shell:          $SHELL ($(${SHELL} --version 2>&1 | head -1))"

# ============================================================================
#  2. 硬件与资源
# ============================================================================
divider "硬件与资源"

section "CPU"
sysctl -n machdep.cpu.brand_string 2>/dev/null | while read -r line; do info "型号: $line"; done
info "核心数: $(sysctl -n hw.ncpu) (物理: $(sysctl -n hw.physicalcpu), 逻辑: $(sysctl -n hw.logicalcpu))"

section "内存"
total_mem=$(($(sysctl -n hw.memsize) / 1073741824))
info "总内存: ${total_mem} GB"
# 内存压力
vm_stat_output=$(vm_stat)
pages_free=$(echo "$vm_stat_output" | awk '/Pages free/ {gsub(/\./,"",$3); print $3+0}')
pages_active=$(echo "$vm_stat_output" | awk '/Pages active/ {gsub(/\./,"",$3); print $3+0}')
pages_wired=$(echo "$vm_stat_output" | awk '/Pages wired down/ {gsub(/\./,"",$4); print $4+0}')
page_size=$(sysctl -n hw.pagesize)
used_mem=$(( (pages_active + pages_wired) * page_size / 1073741824 ))
free_mem=$(( pages_free * page_size / 1073741824 ))
info "活跃+固定: 约 ${used_mem} GB, 空闲: 约 ${free_mem} GB (总共 ${total_mem} GB)"

section "磁盘"
df -H / | awk 'NR==2 {printf "    \033[0;32m✔\033[0m 系统盘: 总共 %s, 已用 %s (%s), 可用 %s\n", $2, $3, $5, $4}'

# ============================================================================
#  3. 开发工具 - 基础
# ============================================================================
divider "开发工具 - 基础"

section "Xcode & Command Line Tools"
if xcode-select -p &>/dev/null; then
    info "CLT 路径: $(xcode-select -p)"
    if cmd_exists xcodebuild; then
        xcode_ver=$(xcodebuild -version 2>/dev/null | head -1)
        if [ -n "$xcode_ver" ]; then
            info "Xcode 版本: $xcode_ver"
        fi
    fi
    pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null | awk '/version/ {print "    \033[0;32m✔\033[0m CLT 版本: "$2}'
else
    warn "Command Line Tools 未安装"
fi

section "Git"
if cmd_exists git; then
    info "版本: $(git --version)"
    git_user=$(git config --global user.name 2>/dev/null || echo "未设置")
    git_email=$(git config --global user.email 2>/dev/null || echo "未设置")
    info "全局用户: $git_user <$git_email>"
else
    warn "Git 未安装"
fi

# ============================================================================
#  4. 包管理器
# ============================================================================
divider "包管理器"

section "Homebrew"
if cmd_exists brew; then
    info "版本: $(brew --version | head -1)"
    info "路径: $(which brew)"
    brew_prefix=$(brew --prefix)
    info "前缀: $brew_prefix"
    formula_count=$(brew list --formula 2>/dev/null | wc -l | tr -d ' ')
    cask_count=$(brew list --cask 2>/dev/null | wc -l | tr -d ' ')
    info "已安装 Formula: $formula_count 个, Cask: $cask_count 个"

    # 检查过时的包
    outdated=$(brew outdated 2>/dev/null | wc -l | tr -d ' ')
    if [ "$outdated" -gt 0 ]; then
        warn "有 $outdated 个过时的包可以更新 (brew outdated 查看详情)"
    else
        info "所有包都是最新的"
    fi
else
    warn "Homebrew 未安装"
fi

section "MacPorts"
if cmd_exists port; then
    info "版本: $(port version)"
    info "已安装端口数: $(port installed 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')"
else
    dim "MacPorts 未安装"
fi

section "Nix"
if cmd_exists nix; then
    info "版本: $(nix --version 2>/dev/null)"
else
    dim "Nix 未安装"
fi

# ============================================================================
#  5. 编程语言 & 运行时
# ============================================================================
divider "编程语言 & 运行时"

section "Python"
if cmd_exists python3; then
    info "python3: $(python3 --version 2>&1) ($(which python3))"
fi
if cmd_exists python; then
    info "python:  $(python --version 2>&1) ($(which python))"
fi
if cmd_exists pip3; then
    pip3_pkgs=$(pip3 list 2>/dev/null | tail -n +3 | wc -l | tr -d ' ')
    info "pip3 已安装包: $pip3_pkgs 个"
fi
if cmd_exists pyenv; then
    info "pyenv 版本: $(pyenv --version)"
    info "pyenv 已安装: $(pyenv versions --bare 2>/dev/null | tr '\n' ' ')"
fi
if cmd_exists conda; then
    info "Conda: $(conda --version 2>&1)"
fi
if cmd_exists pipenv; then info "pipenv: $(pipenv --version 2>&1)"; fi
if cmd_exists poetry; then info "poetry: $(poetry --version 2>&1)"; fi

section "Node.js / JavaScript"
if cmd_exists node; then
    info "Node.js: $(node --version) ($(which node))"
fi
if cmd_exists npm; then
    info "npm: $(npm --version)"
    npm_global=$(npm list -g --depth=0 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')
    info "npm 全局包: $npm_global 个"
fi
if cmd_exists yarn; then info "Yarn: $(yarn --version)"; fi
if cmd_exists pnpm; then info "pnpm: $(pnpm --version)"; fi
if cmd_exists bun; then info "Bun: $(bun --version)"; fi
if cmd_exists deno; then info "Deno: $(deno --version 2>/dev/null | head -1)"; fi
if cmd_exists nvm; then
    info "nvm: 已安装"
elif [ -d "$HOME/.nvm" ]; then
    info "nvm: 已安装 (目录存在: ~/.nvm)"
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        source "$HOME/.nvm/nvm.sh" 2>/dev/null
        info "nvm 管理的 Node 版本: $(nvm ls --no-colors 2>/dev/null | grep -v 'system\|default\|->' | tr -d ' ' | tr '\n' ' ')"
    fi
fi
if cmd_exists fnm; then info "fnm: $(fnm --version)"; fi
if cmd_exists volta; then info "Volta: $(volta --version)"; fi

section "Java / JVM"
if cmd_exists java; then
    java_ver=$(java -version 2>&1 | head -1)
    info "Java: $java_ver"
    if [ -n "${JAVA_HOME:-}" ]; then
        info "JAVA_HOME: $JAVA_HOME"
    fi
fi
if [ -d /Library/Java/JavaVirtualMachines ]; then
    jvm_count=$(ls /Library/Java/JavaVirtualMachines/ 2>/dev/null | wc -l | tr -d ' ')
    if [ "$jvm_count" -gt 0 ]; then
        info "已安装的 JDK ($jvm_count 个):"
        ls /Library/Java/JavaVirtualMachines/ 2>/dev/null | while read -r jdk; do
            dim "  - $jdk"
        done
    fi
fi
if cmd_exists mvn; then info "Maven: $(mvn --version 2>/dev/null | head -1)"; fi
if cmd_exists gradle; then info "Gradle: $(gradle --version 2>/dev/null | grep 'Gradle ' | head -1)"; fi
if cmd_exists kotlin; then info "Kotlin: $(kotlin -version 2>&1)"; fi
if cmd_exists scala; then info "Scala: $(scala -version 2>&1 | head -1)"; fi

section "Go"
if cmd_exists go; then
    info "Go: $(go version)"
    info "GOPATH: ${GOPATH:-$(go env GOPATH)}"
fi

section "Rust"
if cmd_exists rustc; then
    info "Rust: $(rustc --version)"
    if cmd_exists cargo; then info "Cargo: $(cargo --version)"; fi
    if cmd_exists rustup; then
        info "Rustup 工具链: $(rustup show active-toolchain 2>/dev/null)"
    fi
fi

section "Ruby"
if cmd_exists ruby; then
    info "Ruby: $(ruby --version)"
    if cmd_exists gem; then
        info "Gem 已安装: $(gem list 2>/dev/null | wc -l | tr -d ' ') 个"
    fi
fi
if cmd_exists rbenv; then info "rbenv: $(rbenv --version)"; fi
if cmd_exists rvm; then info "rvm: $(rvm --version 2>/dev/null | head -1)"; fi

section "PHP"
if cmd_exists php; then
    info "PHP: $(php --version | head -1)"
    if cmd_exists composer; then info "Composer: $(composer --version 2>/dev/null | head -1)"; fi
fi

section "Swift"
if cmd_exists swift; then
    info "Swift: $(swift --version 2>&1 | head -1)"
fi
if cmd_exists swiftc; then
    info "SwiftC: $(swiftc --version 2>&1 | head -1)"
fi

section "其他语言"
if cmd_exists lua; then info "Lua: $(lua -v 2>&1)"; fi
if cmd_exists perl; then info "Perl: $(perl --version 2>&1 | grep 'version' | head -1 | sed 's/.*(\(.*\))/\1/')"; fi
if cmd_exists R; then info "R: $(R --version 2>/dev/null | head -1)"; fi
if cmd_exists julia; then info "Julia: $(julia --version)"; fi
if cmd_exists elixir; then info "Elixir: $(elixir --version 2>/dev/null | tail -1)"; fi
if cmd_exists erlang 2>/dev/null || cmd_exists erl; then info "Erlang: $(erl -eval 'io:format("~s~n", [erlang:system_info(otp_release)]), halt().' -noshell 2>/dev/null)"; fi
if cmd_exists dotnet; then info ".NET: $(dotnet --version 2>/dev/null)"; fi
if cmd_exists flutter; then info "Flutter: $(flutter --version 2>/dev/null | head -1)"; fi
if cmd_exists dart; then info "Dart: $(dart --version 2>&1)"; fi
if cmd_exists zig; then info "Zig: $(zig version)"; fi

# ============================================================================
#  6. 容器 & 虚拟化
# ============================================================================
divider "容器 & 虚拟化"

if cmd_exists docker; then
    info "Docker: $(docker --version)"
    if docker info &>/dev/null; then
        info "Docker 守护进程: 运行中"
        containers=$(docker ps -a --format '{{.ID}}' 2>/dev/null | wc -l | tr -d ' ')
        images=$(docker images --format '{{.ID}}' 2>/dev/null | wc -l | tr -d ' ')
        info "容器: $containers 个, 镜像: $images 个"
        # Docker 磁盘使用
        docker_disk=$(docker system df --format '{{.Size}}' 2>/dev/null | head -3 | tr '\n' ', ' || echo "未知")
        info "Docker 磁盘占用(约): $docker_disk"
    else
        warn "Docker 守护进程未运行"
    fi
else
    dim "Docker 未安装"
fi

if cmd_exists docker-compose; then info "Docker Compose: $(docker-compose --version 2>/dev/null)"; fi
if cmd_exists podman; then info "Podman: $(podman --version)"; fi
if cmd_exists colima; then info "Colima: $(colima version 2>/dev/null | head -1)"; fi
if cmd_exists lima; then info "Lima: $(lima --version 2>/dev/null)"; fi
if cmd_exists kubectl; then info "kubectl: $(kubectl version --client --short 2>/dev/null || kubectl version --client 2>/dev/null | head -1)"; fi
if cmd_exists minikube; then info "Minikube: $(minikube version --short 2>/dev/null)"; fi
if cmd_exists helm; then info "Helm: $(helm version --short 2>/dev/null)"; fi
if cmd_exists vagrant; then info "Vagrant: $(vagrant --version)"; fi
if cmd_exists VBoxManage; then info "VirtualBox: $(VBoxManage --version 2>/dev/null)"; fi
if cmd_exists multipass; then info "Multipass: $(multipass version 2>/dev/null | head -1)"; fi

# ============================================================================
#  7. 数据库 & 中间件
# ============================================================================
divider "数据库 & 中间件"

if cmd_exists mysql; then info "MySQL Client: $(mysql --version)"; fi
if cmd_exists mysqld; then info "MySQL Server: $(mysqld --version 2>/dev/null | head -1)"; fi
if cmd_exists psql; then info "PostgreSQL: $(psql --version)"; fi
if cmd_exists mongod; then info "MongoDB: $(mongod --version 2>/dev/null | head -1)"; fi
if cmd_exists mongosh; then info "mongosh: $(mongosh --version 2>/dev/null)"; fi
if cmd_exists redis-server; then info "Redis: $(redis-server --version)"; fi
if cmd_exists redis-cli; then info "Redis CLI: $(redis-cli --version)"; fi
if cmd_exists sqlite3; then info "SQLite: $(sqlite3 --version)"; fi
if cmd_exists nginx; then info "Nginx: $(nginx -v 2>&1)"; fi
if cmd_exists httpd; then info "Apache: $(httpd -v 2>/dev/null | head -1)"; fi
if cmd_exists rabbitmqctl; then info "RabbitMQ: $(rabbitmqctl version 2>/dev/null)"; fi
if cmd_exists kafka-server-start 2>/dev/null || [ -d /usr/local/opt/kafka ]; then info "Kafka: 已安装"; fi
if cmd_exists elasticsearch 2>/dev/null || [ -d /usr/local/opt/elasticsearch ]; then info "Elasticsearch: 已安装"; fi

# ============================================================================
#  8. 云 & DevOps 工具
# ============================================================================
divider "云 & DevOps 工具"

if cmd_exists aws; then info "AWS CLI: $(aws --version 2>&1)"; fi
if cmd_exists gcloud; then info "Google Cloud SDK: $(gcloud --version 2>/dev/null | head -1)"; fi
if cmd_exists az; then info "Azure CLI: $(az --version 2>/dev/null | head -1)"; fi
if cmd_exists terraform; then info "Terraform: $(terraform --version 2>/dev/null | head -1)"; fi
if cmd_exists ansible; then info "Ansible: $(ansible --version 2>/dev/null | head -1)"; fi
if cmd_exists gh; then info "GitHub CLI: $(gh --version 2>/dev/null | head -1)"; fi
if cmd_exists vercel; then info "Vercel CLI: $(vercel --version 2>/dev/null)"; fi
if cmd_exists netlify; then info "Netlify CLI: $(netlify --version 2>/dev/null)"; fi

# ============================================================================
#  9. 编辑器 & IDE
# ============================================================================
divider "编辑器 & IDE"

if cmd_exists code; then info "VS Code: $(code --version 2>/dev/null | head -1)"; fi
if cmd_exists cursor; then info "Cursor: 已安装"; fi
if cmd_exists idea; then info "IntelliJ IDEA: 已安装"; fi
if [ -d "/Applications/IntelliJ IDEA.app" ] || [ -d "/Applications/IntelliJ IDEA CE.app" ]; then
    info "IntelliJ IDEA: 已安装 (Applications)"
fi
if cmd_exists vim; then info "Vim: $(vim --version 2>/dev/null | head -1)"; fi
if cmd_exists nvim; then info "Neovim: $(nvim --version 2>/dev/null | head -1)"; fi
if cmd_exists emacs; then info "Emacs: $(emacs --version 2>/dev/null | head -1)"; fi
if cmd_exists subl; then info "Sublime Text: 已安装"; fi
if [ -d "/Applications/Xcode.app" ]; then info "Xcode.app: 已安装"; fi
if [ -d "/Applications/Android Studio.app" ]; then info "Android Studio: 已安装"; fi

# ============================================================================
#  10. 常用开发工具
# ============================================================================
divider "常用开发工具"

section "终端 & Shell 工具"
if cmd_exists tmux; then info "tmux: $(tmux -V)"; fi
if cmd_exists screen; then info "screen: 已安装"; fi
if [ -d "$HOME/.oh-my-zsh" ]; then info "Oh My Zsh: 已安装"; fi
if cmd_exists starship; then info "Starship: $(starship --version 2>/dev/null | head -1)"; fi
if cmd_exists fig 2>/dev/null || [ -d "/Applications/Fig.app" ]; then info "Fig: 已安装"; fi
if cmd_exists warp 2>/dev/null || [ -d "/Applications/Warp.app" ]; then info "Warp: 已安装"; fi
if [ -d "/Applications/iTerm.app" ]; then info "iTerm2: 已安装"; fi

section "网络 & 调试"
if cmd_exists curl; then info "curl: $(curl --version 2>/dev/null | head -1)"; fi
if cmd_exists wget; then info "wget: $(wget --version 2>/dev/null | head -1)"; fi
if cmd_exists httpie 2>/dev/null || cmd_exists http; then info "HTTPie: $(http --version 2>/dev/null)"; fi
if cmd_exists jq; then info "jq: $(jq --version)"; fi
if cmd_exists yq; then info "yq: $(yq --version 2>/dev/null | head -1)"; fi
if cmd_exists ngrok; then info "ngrok: $(ngrok --version 2>/dev/null)"; fi
if cmd_exists mitmproxy; then info "mitmproxy: $(mitmproxy --version 2>/dev/null | head -1)"; fi
if [ -d "/Applications/Charles.app" ]; then info "Charles Proxy: 已安装"; fi
if [ -d "/Applications/Proxyman.app" ]; then info "Proxyman: 已安装"; fi
if [ -d "/Applications/Postman.app" ]; then info "Postman: 已安装"; fi

section "搜索 & 文件工具"
if cmd_exists rg; then info "ripgrep: $(rg --version | head -1)"; fi
if cmd_exists fd; then info "fd: $(fd --version)"; fi
if cmd_exists fzf; then info "fzf: $(fzf --version 2>/dev/null)"; fi
if cmd_exists ag; then info "The Silver Searcher: $(ag --version 2>/dev/null | head -1)"; fi
if cmd_exists bat; then info "bat: $(bat --version)"; fi
if cmd_exists eza; then info "eza: $(eza --version 2>/dev/null | head -1)"; fi
if cmd_exists exa; then info "exa: $(exa --version 2>/dev/null | head -1)"; fi
if cmd_exists tree; then info "tree: $(tree --version 2>/dev/null)"; fi
if cmd_exists htop; then info "htop: $(htop --version 2>/dev/null | head -1)"; fi
if cmd_exists btop; then info "btop: 已安装"; fi

section "版本控制 & 协作"
if cmd_exists git-lfs; then info "Git LFS: $(git-lfs --version 2>/dev/null)"; fi
if cmd_exists svn; then info "SVN: $(svn --version 2>/dev/null | head -1)"; fi
if cmd_exists hg; then info "Mercurial: $(hg --version 2>/dev/null | head -1)"; fi
if cmd_exists lazygit; then info "lazygit: $(lazygit --version 2>/dev/null | head -1)"; fi
if cmd_exists tig; then info "tig: $(tig --version 2>/dev/null)"; fi

# ============================================================================
#  11. Shell 配置文件检查
# ============================================================================
divider "Shell 配置文件"

config_files=(
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.zshenv"
    "$HOME/.bash_profile"
    "$HOME/.bashrc"
    "$HOME/.profile"
    "$HOME/.zsh_history"
)

for f in "${config_files[@]}"; do
    if [ -f "$f" ]; then
        size=$(du -h "$f" 2>/dev/null | awk '{print $1}')
        lines=$(wc -l < "$f" 2>/dev/null | tr -d ' ')
        info "$(basename $f): ${lines} 行, ${size}"
    fi
done

# 检查 PATH 中的目录数量
path_count=$(echo "$PATH" | tr ':' '\n' | wc -l | tr -d ' ')
info "PATH 中有 $path_count 个目录"

# 检查 PATH 中不存在的目录
echo ""
section "PATH 中不存在的目录 (可清理)"
found_invalid=false
echo "$PATH" | tr ':' '\n' | while read -r p; do
    if [ ! -d "$p" ]; then
        warn "$p"
        found_invalid=true
    fi
done

# ============================================================================
#  12. 磁盘空间分析（开发相关目录）
# ============================================================================
divider "开发相关目录空间占用"

dev_dirs=(
    "$HOME/.npm"
    "$HOME/.yarn"
    "$HOME/.pnpm-store"
    "$HOME/.gradle"
    "$HOME/.m2"
    "$HOME/.cargo"
    "$HOME/.rustup"
    "$HOME/.go"
    "$HOME/go"
    "$HOME/.pyenv"
    "$HOME/.conda"
    "$HOME/.nvm"
    "$HOME/.rbenv"
    "$HOME/.gem"
    "$HOME/.cocoapods"
    "$HOME/.docker"
    "$HOME/.vagrant.d"
    "$HOME/.kube"
    "$HOME/.vscode"
    "$HOME/.local"
)

for d in "${dev_dirs[@]}"; do
    if [ -d "$d" ]; then
        # 使用 timeout 避免大目录卡住（最多等 5 秒）
        size=$(timeout 5 du -sh "$d" 2>/dev/null | awk '{print $1}')
        if [ -n "$size" ]; then
            info "$(echo "$d" | sed "s|$HOME|~|"): $size"
        else
            warn "$(echo "$d" | sed "s|$HOME|~|"): 计算超时(目录可能较大)"
        fi
    fi
done

# 大目录单独处理，只显示存在的
large_dirs=(
    "$HOME/Library/Caches"
    "$HOME/Library/Developer"
    "$HOME/Library/Android"
)
for d in "${large_dirs[@]}"; do
    if [ -d "$d" ]; then
        size=$(timeout 10 du -sh "$d" 2>/dev/null | awk '{print $1}')
        if [ -n "$size" ]; then
            info "$(echo "$d" | sed "s|$HOME|~|"): $size"
        else
            warn "$(echo "$d" | sed "s|$HOME|~|"): 计算超时(目录可能很大)"
        fi
    fi
done

# Xcode DerivedData
if [ -d "$HOME/Library/Developer/Xcode/DerivedData" ]; then
    dd_size=$(timeout 10 du -sh "$HOME/Library/Developer/Xcode/DerivedData" 2>/dev/null | awk '{print $1}')
    if [ -n "$dd_size" ]; then
        warn "Xcode DerivedData: $dd_size (可用 rm -rf ~/Library/Developer/Xcode/DerivedData 清理)"
    fi
fi

# ============================================================================
#  13. 安全相关
# ============================================================================
divider "安全相关检查"

section "SSH"
if [ -d "$HOME/.ssh" ]; then
    key_count=$(ls "$HOME/.ssh/"*.pub 2>/dev/null | wc -l | tr -d ' ')
    info "SSH 公钥: $key_count 个"
    ls "$HOME/.ssh/"*.pub 2>/dev/null | while read -r key; do
        dim "  - $(basename "$key"): $(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $1, $4}')"
    done
    if [ -f "$HOME/.ssh/config" ]; then
        host_count=$(grep -c "^Host " "$HOME/.ssh/config" 2>/dev/null | tr -d '[:space:]' || echo "0")
        info "SSH Config: $host_count 个 Host 配置"
    fi
fi

section "GPG"
if cmd_exists gpg; then
    gpg_keys=$(gpg --list-keys 2>/dev/null | grep -c "^pub" || echo "0")
    info "GPG 密钥: $gpg_keys 个"
fi

section "系统安全"
# SIP 状态
sip_status=$(csrutil status 2>/dev/null || echo "未知")
info "SIP: $sip_status"

# FileVault
fv_status=$(fdesetup status 2>/dev/null || echo "未知")
info "FileVault: $fv_status"

# Gatekeeper
gk_status=$(spctl --status 2>/dev/null || echo "未知")
info "Gatekeeper: $gk_status"

# ============================================================================
#  14. 启动项 & 后台服务
# ============================================================================
divider "启动项 & 后台服务"

section "Homebrew 服务"
if cmd_exists brew; then
    brew services list 2>/dev/null | tail -n +2 | while read -r line; do
        svc_name=$(echo "$line" | awk '{print $1}')
        svc_status=$(echo "$line" | awk '{print $2}')
        if [ "$svc_status" = "started" ]; then
            info "$svc_name: 运行中"
        else
            dim "$svc_name: $svc_status"
        fi
    done
fi

section "Launch Agents (用户级)"
user_agents=$(ls "$HOME/Library/LaunchAgents/" 2>/dev/null | wc -l | tr -d ' ')
info "用户启动项: $user_agents 个"
if [ "$user_agents" -gt 0 ]; then
    ls "$HOME/Library/LaunchAgents/" 2>/dev/null | head -15 | while read -r f; do
        dim "  - $f"
    done
    if [ "$user_agents" -gt 15 ]; then
        dim "  ... 还有 $((user_agents - 15)) 个"
    fi
fi

section "Launch Daemons (系统级 - 第三方)"
third_party_daemons=$(ls /Library/LaunchDaemons/ 2>/dev/null | grep -v "com.apple" | wc -l | tr -d ' ')
if [ "$third_party_daemons" -gt 0 ]; then
    info "第三方系统守护进程: $third_party_daemons 个"
    ls /Library/LaunchDaemons/ 2>/dev/null | grep -v "com.apple" | head -10 | while read -r f; do
        dim "  - $f"
    done
fi

# ============================================================================
#  15. 网络环境
# ============================================================================
divider "网络环境"

active_iface=$(route get default 2>/dev/null | awk '/interface/ {print $2}')
if [ -n "$active_iface" ]; then
    info "活跃网络接口: $active_iface"
    ip_addr=$(ifconfig "$active_iface" 2>/dev/null | awk '/inet / {print $2}')
    info "本地 IP: $ip_addr"
fi

# 代理检查
section "代理设置"
if [ -n "${http_proxy:-}" ]; then info "http_proxy: $http_proxy"; fi
if [ -n "${https_proxy:-}" ]; then info "https_proxy: $https_proxy"; fi
if [ -n "${HTTP_PROXY:-}" ]; then info "HTTP_PROXY: $HTTP_PROXY"; fi
if [ -n "${HTTPS_PROXY:-}" ]; then info "HTTPS_PROXY: $HTTPS_PROXY"; fi
if [ -n "${ALL_PROXY:-}" ]; then info "ALL_PROXY: $ALL_PROXY"; fi
if [ -n "${NO_PROXY:-}" ]; then info "NO_PROXY: $NO_PROXY"; fi
if [ -z "${http_proxy:-}" ] && [ -z "${https_proxy:-}" ] && [ -z "${ALL_PROXY:-}" ]; then
    dim "未检测到 Shell 代理环境变量"
fi

# npm/git 代理
if cmd_exists npm; then
    npm_proxy=$(npm config get proxy 2>/dev/null)
    if [ -n "$npm_proxy" ] && [ "$npm_proxy" != "null" ] && [ "$npm_proxy" != "undefined" ]; then
        info "npm proxy: $npm_proxy"
    fi
    npm_registry=$(npm config get registry 2>/dev/null)
    info "npm registry: $npm_registry"
fi

git_proxy=$(git config --global http.proxy 2>/dev/null || true)
if [ -n "$git_proxy" ]; then
    info "Git http.proxy: $git_proxy"
fi

# ============================================================================
#  16. 汇总建议
# ============================================================================
divider "清理与优化建议"

echo ""
echo -e "  ${BOLD}以下是一些常见的清理建议:${NC}"
echo ""
echo -e "    ${CYAN}1.${NC} Homebrew 清理缓存:          ${DIM}brew cleanup --prune=all${NC}"
echo -e "    ${CYAN}2.${NC} 清理 npm 缓存:              ${DIM}npm cache clean --force${NC}"
echo -e "    ${CYAN}3.${NC} 清理 Xcode DerivedData:      ${DIM}rm -rf ~/Library/Developer/Xcode/DerivedData${NC}"
echo -e "    ${CYAN}4.${NC} 清理 Docker 无用资源:        ${DIM}docker system prune -a${NC}"
echo -e "    ${CYAN}5.${NC} 清理 pip 缓存:               ${DIM}pip cache purge${NC}"
echo -e "    ${CYAN}6.${NC} 清理 Gradle 缓存:            ${DIM}rm -rf ~/.gradle/caches${NC}"
echo -e "    ${CYAN}7.${NC} 清理 CocoaPods 缓存:         ${DIM}pod cache clean --all${NC}"
echo -e "    ${CYAN}8.${NC} 查看大文件:                  ${DIM}du -sh ~/Library/Caches/* | sort -rh | head -20${NC}"
echo -e "    ${CYAN}9.${NC} 检查过时 Homebrew 包:        ${DIM}brew outdated${NC}"
echo -e "   ${CYAN}10.${NC} 清理 PATH 无效条目:          ${DIM}检查 ~/.zshrc 中的 PATH 配置${NC}"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}  检查完成! $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
