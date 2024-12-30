return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'javascript', 'jsdoc' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
