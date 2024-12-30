local utils = require 'adam.utils'

return {
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'tflint' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'terraform', 'hcl' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    specs = {
      {
        'ANGkeith/telescope-terraform-doc.nvim',
        ft = { 'terraform', 'hcl' },
        config = function()
          utils.on_load('telescope.nvim', function()
            require('telescope').load_extension 'terraform_doc'
          end)
        end,
      },
      {
        'cappyzawa/telescope-terraform.nvim',
        ft = { 'terraform', 'hcl' },
        config = function()
          utils.on_load('telescope.nvim', function()
            require('telescope').load_extension 'terraform'
          end)
        end,
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        hcl = { 'packer_fmt' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        terraform = { 'terraform_validate' },
        tf = { 'terraform_validate' },
      },
    },
  },
  {
    'ANGkeith/telescope-terraform-doc.nvim',
    version = '2.1.0',
    ft = { 'terraform', 'hcl' },
    config = function()
      utils.on_load('telescope.nvim', function()
        require('telescope').load_extension 'terraform_doc'
      end)
    end,
  },
  {
    'cappyzawa/telescope-terraform.nvim',
    commit = '072c970',
    ft = { 'terraform', 'hcl' },
    config = function()
      utils.on_load('telescope.nvim', function()
        require('telescope').load_extension 'terraform'
      end)
    end,
  },
}
