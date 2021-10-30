call plug#begin(stdpath('data') . '/plugged')

" Zen Mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Readability
Plug 'jbgutierrez/vim-better-comments'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" UI
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'AckslD/nvim-whichkey-setup.lua'

" Utils
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'andymass/vim-matchup'
Plug 'mattn/emmet-vim'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'editorconfig/editorconfig-vim'
Plug 'kristijanhusak/orgmode.nvim', { 'branch': 'tree-sitter' }

" Theme
Plug 'drewtempelmeyer/palenight.vim'

" Status Line
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim51' }
Plug 'folke/lsp-colors.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'petertriho/cmp-git'
Plug 'onsails/lspkind-nvim'

" File Manager
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'

call plug#end()
