return {
  'folke/which-key.nvim',
  version = '3.15.0',
  opts = {
    spec = {
      { '<BS>', desc = 'Decrement Selection', mode = 'x' },
      { '<c-space>', desc = 'Increment Selection', mode = { 'x', 'n' } },
    },
  },
}
