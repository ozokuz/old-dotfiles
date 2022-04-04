local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Make packer manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'pacokwon/onedarkhc.vim'

  -- Tmux Integration
  use 'christoomey/vim-tmux-navigator'

  -- Zen Mode
  use {
    'folke/zen-mode.nvim',
    requires = { 'folke/twilight.nvim' },
    config = function()
      require('twilight').setup()
      require('zen-mode').setup()
    end
  }

  -- Utils
  use 'tpope/vim-speeddating'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'windwp/nvim-autopairs'
  use 'andymass/vim-matchup'
  use 'mattn/emmet-vim'
  use 'justinmk/vim-sneak'
  use 'unblevable/quick-scope'
  use 'editorconfig/editorconfig-vim'
  use { 'kristijanhusak/orgmode.nvim', branch = 'tree-sitter' }

  -- Readability
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }

  -- Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'p00f/nvim-ts-rainbow'
    },
    config = function() require('ozokuz.treesitter').setup() end
  }

  -- Which Key
  use {
    'AckslD/nvim-whichkey-setup.lua',
    requires = { 'liuchengxu/vim-which-key' }
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'junegunn/gv.vim'
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- File Manager
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('nvim-tree').setup {} end
  }

  -- Navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      },
      'nvim-telescope/telescope-media-files.nvim',
      'nvim-telescope/telescope-packer.nvim',
      'nvim-telescope/telescope-github.nvim',
      'nvim-telescope/telescope-symbols.nvim'
    },
    config = function() require('ozokuz.telescope').setup() end
  }

  -- LSP
  use {
    'tami5/lspsaga.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
      'folke/lsp-colors.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'ray-x/lsp_signature.nvim'
    },
    config = function() require('ozokuz.lsp').setup() end
  }

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
      'onsails/lspkind-nvim'
    },
    config = function() require('ozokuz.lsp.completion').setup() end
  }

  -- Markdown Preview
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
  }

  -- Status Line
  use 'nvim-lualine/lualine.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
