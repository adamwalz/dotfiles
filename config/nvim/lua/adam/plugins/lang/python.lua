local utils = require 'adam.utils'

local lsp = 'pyright'
local ruff = 'ruff'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'python', 'ninja', 'rst' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = 'messages' },
          init_options = {
            settings = {
              logLevel = 'error',
            },
          },
          keys = {
            {
              '<leader>co',
              utils.lsp.action['source.organizeImports'],
              desc = 'Organize Imports',
            },
          },
        },
        ruff_lsp = {
          keys = {
            {
              '<leader>co',
              utils.lsp.action['source.organizeImports'],
              desc = 'Organize Imports',
            },
          },
        },
      },
      setup = {
        [ruff] = function()
          utils.lsp.on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end, ruff)
        end,
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local servers = { 'pyright', 'basedpyright', 'ruff', 'ruff_lsp', ruff, lsp }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].enabled = server == lsp or server == ruff
      end
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, 'python')
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
      config = function()
        if vim.fn.has 'win32' == 1 then
          require('dap-python').setup(utils.get_pkg_path('debugpy', '/venv/Scripts/pythonw.exe'))
        else
          require('dap-python').setup(utils.get_pkg_path('debugpy', '/venv/bin/python'))
        end
      end,
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      {
        'nvim-neotest/neotest-python',
        commit = 'a2861ab',
      }
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap-python',
    commit = '3428282',
  -- stylua: ignore
  keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  },
    config = function()
      if vim.fn.has 'win32' == 1 then
        require('dap-python').setup(utils.get_pkg_path('debugpy', '/venv/Scripts/pythonw.exe'))
      else
        require('dap-python').setup(utils.get_pkg_path('debugpy', '/venv/bin/python'))
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      handlers = {
        python = function() end,
      },
    },
  },
}
