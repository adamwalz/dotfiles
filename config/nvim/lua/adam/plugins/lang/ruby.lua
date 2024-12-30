local lsp = 'ruby_lsp'
local formatter = 'rubocop'

return {
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'erb-formatter', 'erb-lint' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ruby' } },
  },
  {
    'neovim/nvim-lspconfig',
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ruby_lsp = {
          enabled = lsp == 'ruby_lsp',
        },
        solargraph = {
          enabled = lsp == 'solargraph',
        },
        rubocop = {
          -- If Solargraph and Rubocop are both enabled as an LSP,
          -- diagnostics will be duplicated because Solargraph
          -- already calls Rubocop if it is installed
          enabled = formatter == 'rubocop' and lsp ~= 'solargraph',
        },
        standardrb = {
          enabled = formatter == 'standardrb',
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ruby = { formatter },
        eruby = { 'erb_format' },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'suketa/nvim-dap-ruby',
      commit = '4176405',
      config = function()
        require('dap-ruby').setup()
      end,
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'olimorris/neotest-rspec',
      commit = 'f8c91ed',
    },
    opts = {
      adapters = {
        ['neotest-rspec'] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          -- rspec_cmd = function()
          --   return vim.tbl_flatten({
          --     "bundle",
          --     "exec",
          --     "rspec",
          --   })
          -- end,
        },
      },
    },
  },
}
