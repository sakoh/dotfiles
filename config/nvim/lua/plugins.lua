-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
--vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- Plugins can also depend on rocks from luarocks.org:
  --use {
    --'my/supercoolplugin',
    --rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  --}

  -- You can specify rocks in isolation
  use_rocks 'penlight'
  use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  --use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  --use {
    --'glepnir/galaxyline.nvim', config = function() require'statusline' end,
    --requires = {'kyazdani42/nvim-web-devicons'}
  --}
  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }


  -- You can specify multiple plugins in a single call
  --use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}

  -- Sako's Plugins from previous vim plug config
  use 'davidhalter/jedi-vim'

  --use 'vim-airline/vim-airline'

  --use 'beauwilliams/statusline.lua'

  --use 'vim-airline/vim-airline-themes'

  use 'scrooloose/nerdcommenter'

  use 'cocopon/pgmnt.vim'

  use 'cocopon/iceberg.vim'

  use 'arcticicestudio/nord-vim'

  use 'crucerucalin/qml.vim'

  --use 'preservim/nerdtree'

  --use 'tiagofumo/vim-nerdtree-syntax-highlight'

  --use 'mg979/vim-visual-multi'

  use 'vimwiki/vimwiki'

  use 'tools-life/taskwiki'

  use 'tpope/vim-fugitive'

  use 'ryanoasis/vim-devicons'

  --use 'neoclide/coc.nvim'

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'kosayoda/nvim-lightbulb'

  use 'neovim/nvim-lspconfig'

  use 'jose-elias-alvarez/null-ls.nvim'

  use 'MunifTanjim/eslint.nvim'

  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
 
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
end)
