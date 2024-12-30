return {
  {
    'mason.nvim',
    opts = { ensure_installed = { 'swiftlint' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'swift' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        sourcekit = {
          cmd = {
            vim.fn.trim(vim.fn.system 'xcrun --find sourcekit-lsp'),
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
          init_options = {
            timeoutInSeconds = 30,
          },
          settings = {
            trace = {
              server = 'verbose',
            },
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        swift = { 'swift_format' },
      },
      formatters = {
        swift_format = {
          command = 'swift-format',
          args = {
            'format',
            '--in-place',
            '--parallel',
            '$FILENAME',
          },
        },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        swift = { 'swiftlint' },
      },
    },
  },
  {
    'echasnovski/mini.icons',
    opts = {
      filetype = {
        swift = { glyph = '󰛥', hl = 'MiniIconsOrange' },
      },
    },
  },
}
