" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup
" 显示行号
set number












"插件管理==============================================================================================start
set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plug 'VundleVim/Vundle.vim'

" markdown语法高亮
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" markdown 预览

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
"Plug 'iamcco/mathjax-support-for-mkdp'
"Plugin 'iamcco/markdown-preview.vim'
"Plugin 'iamcco/markdown-preview.vim'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'JamshedVesuna/vim-markdown-preview'
" 显示目录树
Plug 'scrooloose/nerdtree'
" 所有的tab显示一样的tree
Plug 'jistr/vim-nerdtree-tabs'
" 显示git状态
Plug 'Xuyuanp/nerdtree-git-plugin'
" git插件
Plug 'tpope/vim-fugitive'
" 你的所有插件需要在下面这行之前
call plug#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 简要帮助文档
" :PlugList       - 列出所有已配置的插件
" :PlugInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PlugSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PlugClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后
"
"插件管理==============================================================================================end








"拷贝当前编辑的文件到系统剪切板=========================================================================start
function GetCurFilePath()
    call setreg('+',expand('%:p'))
endfunction

"定义一个快捷键

nnoremap <silent> <F2> : call GetCurFilePath()<cr>


"拷贝当前编辑的文件到系统剪切板=========================================================================end
"自动保存
let g:auto_save = 1


"NERDTree配置=========================================================================start
"The NERD tree
"F3触发，设置宽度为30,显示书签
map <F3> :NERDTreeToggle<CR>
let NERDTreeWinSize = 30
let NERDTreeShowBookmarks = 1
"高亮当前行
let NERDTreeHighlightCursorline = 1
"从NERDTree打开文件后自动关闭NERDTree
"let NERDTreeQuitOnOpen = 1
"显示隐藏文件
let g:NERDTreeShowHidden = 1
"忽略特定文件和目录
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]
"显示行号
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
"自动打开NERDTree
autocmd VimEnter * NERDTree
">> NERDTREE-GIT
  " Special characters
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
   \ }
">> NERDTree-Tabs
let g:nerdtree_tabs_open_on_console_startup=1 "Auto-open Nerdtree-tabs on VIM enter

"NERDTree配置=========================================================================end
"
"markdown-preview配置=========================================================================start
" normal/insert

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


" example
nmap <C-p> <Plug>MarkdownPreviewToggle
"markdown-preview配置=========================================================================end
