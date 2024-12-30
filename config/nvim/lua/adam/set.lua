vim.g.autoformat = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 3 -- Number of lines to keep above and below the cursor

vim.opt.autowrite = true

vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions

vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

vim.opt.foldlevel = 99
vim.opt.formatexpr = "v:lua.require'adam.utils'.format.formatexpr()"
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'

vim.opt.laststatus = 3 -- global statusline

vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup

vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

vim.opt.shiftround = true -- Round indent

vim.opt.shortmess:append { W = true, I = true, c = true, C = true }

vim.opt.sidescrolloff = 8 -- Columns of context

vim.opt.smartindent = true -- Insert indents automatically

vim.opt.spelllang = { 'en' }

vim.opt.splitkeep = 'screen'

vim.opt.termguicolors = true -- True color support

vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode

vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode

vim.opt.winminwidth = 5 -- Minimum window width

vim.opt.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
  vim.opt.foldexpr = "v:lua.require'adam.utils'.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
else
  vim.opt.foldmethod = "indent"
  vim.opt.foldtext = "v:lua.require'adam.utils'.ui.foldtext()"
end

vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/env/neovim-py3/bin/python')

-- vim: ts=2 sts=2 sw=2 et
