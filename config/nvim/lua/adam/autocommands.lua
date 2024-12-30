-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set color scheme
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  callback = function()
    local status_ok = pcall(function()
      require('lazy').load { plugins = { 'catppuccin' } }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end)
    if not status_ok then
      vim.notify('Failed to load colorscheme, falling back to default', vim.log.levels.WARN)
      vim.cmd.colorscheme 'default'
    end
  end,
})
