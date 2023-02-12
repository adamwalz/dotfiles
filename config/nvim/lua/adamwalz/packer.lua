local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use('tanvirtin/monokai.nvim')
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')

  -- Git
  use('tpope/vim-fugitive') -- git wrapper for vim
  use('octref/RootIgnore') -- set 'wildignore' from git repo root or home folder
  use('airblade/vim-gitgutter') -- shows a git diff in the gutter

  -- File navigation
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- status line
  use('nvim-lualine/lualine.nvim')

  -- terminal
  use('voldikss/vim-floaterm')

  -- color html codes
  use('norcalli/nvim-colorizer.lua')

  -- LSP (Language Server Provider)
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Completion framework
      {'hrsh7th/nvim-cmp'},

      -- LSP completion source
      {'hrsh7th/cmp-nvim-lsp'},

      -- Useful completion sources
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-cmdline'},

      -- Snippets
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},

      -- Github Copilot
      {'zbirenbaum/copilot.lua'},
      {'zbirenbaum/copilot-cmp'},

      -- Rust
      {'simrat39/rust-tools.nvim'}
    }
  }

  use {'windwp/nvim-autopairs'}

  use('puremourning/vimspector')

  use("folke/zen-mode.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
