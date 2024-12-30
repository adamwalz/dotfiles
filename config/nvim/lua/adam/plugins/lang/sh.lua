return {
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'shfmt' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        sh = { 'shfmt' },
      },
    },
  },
}
