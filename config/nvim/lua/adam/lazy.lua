-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazy_version = '11.16.2'
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=v' .. lazy_version, lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }

local function lazy_file()
  -- Add support for the LazyFile event
  local Event = require 'lazy.core.handler.event'

  Event.mappings.LazyFile = { id = 'LazyFile', event = lazy_file_events }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile
end

lazy_file()

require('lazy').setup {
  version = lazy_version,
  spec = {
    { import = 'adam.plugins.utils' },
    { import = 'adam.plugins.coding' },
    { import = 'adam.plugins.treesitter' },
    { import = 'adam.plugins.lsp' },
    { import = 'adam.plugins.lang' },
    { import = 'adam.plugins.editor' },
    { import = 'adam.plugins.formatting' },
    { import = 'adam.plugins.linting' },
    { import = 'adam.plugins.dap' },
    { import = 'adam.plugins.test' },
    { import = 'adam.plugins.colorscheme' },
    { import = 'adam.plugins.ui' },
  },
  change_detection = { notify = false },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  defaults = {
    version = '*',
  },
}
