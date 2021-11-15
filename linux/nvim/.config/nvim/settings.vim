" Set leader key
nnoremap <Space> <Nop>
let mapleader=" "

" No swap or backup files
set nobackup
set noswapfile

" Extend word objects that have a dash (-)
set iskeyword+=-

" Enable editing multiple files
set hidden

" No line wrapping
set nowrap

" File Encoding
set encoding=utf-8
set fileencoding=utf-8

" Always show cursor
set ruler

" Enable mouse
set mouse=a

" Split below and to the right by default
set splitbelow
set splitright

" 256 color support
set t_Co=256

" true color support
set termguicolors

" no concealed text
set conceallevel=0

" Indentation
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent

" line numbers
set number

" highlight current line
set cursorline

" tell vim that the background is dark
set background=dark

" show tabs
set showtabline=2

" hide mode line
set noshowmode

" show signcolumn
set signcolumn=yes

" stop comments from automatically continuing on the next line
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" use system clipboard
set clipboard=unnamedplus

" set theme
colorscheme onedarkhc
