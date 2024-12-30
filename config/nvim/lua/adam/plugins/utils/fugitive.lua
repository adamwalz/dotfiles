return {
  'tpope/vim-fugitive',
  version = '3.7.0',
  config = function()
    -- Basic keymaps for common Fugitive commands
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { desc = 'Git write (stage) current file' })
    vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
    vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>', { desc = 'Git diff' })
  end,
}
