vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
vim.g.ruby_host_prog = "/opt/homebrew/lib/ruby/gems/3.1.0/bin/neovim-ruby-host"
vim.g.load_perl_provider = 0

vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true

vim.opt.compatible = false -- don't need to be compatible with old vim

vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.smartindent = true -- smart indenting for c-like languages
vim.opt.shiftround = true -- round indent to multiple of `shiftwidth`. Applies to > and < commands
vim.opt.shiftwidth = 2 -- number of spaces to use for each indent
vim.opt.expandtab = true -- use spaces to insert a <Tab><Paste>
vim.opt.tabstop = 2 -- number of spaces that a <Tab> counts for
vim.opt.softtabstop = 2 -- number of spaces that a <Tab> counts for while editing

-- When smarttab is on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
-- 'tabstop' or 'softtabstop' are used in other places
vim.opt.smarttab = true

vim.opt.textwidth = 500 -- maximum width of text that is being inserted<Paste>

vim.opt.formatoptions = (
  'q' .. -- allow formatting of comments with gq
  'r' .. -- automatically insert the current comment leader after <Enter> in insert mode
  'n' .. -- when formatting text, recognize numbered lists
  '1' .. -- don't break a line after a one-letter word
  'j'    -- delete comment character when joining lines
)

vim.opt.list = true -- list mode: useful to see the difference between tabs and spaces and for trailing whitespace
vim.opt.listchars = "tab:▸ ,trail:·,eol:¬" -- show extra space characters
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- show current line number also

vim.opt.backspace = "indent,eol,start" -- influences the use of <BS>, <Del> in Insert mode
vim.opt.autoread = true -- autoread a file when it is changes outside of vim

vim.opt.showcmd = true -- show the command in the last line

-- specifies how keyword completion works when CTRL-P or CTRL-N are used
vim.opt.complete = (
  ".," .. -- scan the current buffer
  "w," .. -- scan buffers from other windows
  "b," .. -- scan other loaded buffers that are in the buffer list
  "u," .. -- scan the unloaded buffers that are in the buffer list
  "t," .. -- tag completion
  "kspell" -- use the currently active spell checking
)
-- better completion experience
vim.opt.completeopt = {
  'menuone', -- popup even when there's only one match
  'noselect', -- do not select, force to select one from the menu
  'noinsert', -- do not insert text until a selection is made
}
vim.opt.shortmess = vim.opt.shortmess + { c = true } -- avoid showing extra messages when using completion

vim.opt.showmatch = true -- when a bracket is inserted, briefly jump to the matching one
vim.opt.matchtime = 3 -- tenths of a second to show the matching paren

vim.opt.hlsearch = false -- don't highlight all search matches
vim.opt.incsearch = true -- show search results as they are typed
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- override the 'ignorecase' option if the search pattern contains uppercase characters

vim.opt.swapfile = false -- don't use a swapfile for the buffer
vim.opt.backup = false -- don't make a backup before overwriting a file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- list of directory names for undo files
vim.opt.undofile = true -- automatically save undo history to an undo file
vim.opt.history = 1000 -- record a history of ":" commands
vim.opt.undolevels = 1000 -- number of changes that can be undone
vim.opt.undoreload = 10000 -- save the whole buffer for undo when reloading it

vim.opt.cursorline = true -- highlight the screen line of the cursor
vim.opt.ruler = true -- show the line and column number in the cursor position

vim.opt.scrolljump = 5 -- minimum number of lines to scroll when the cursor gets off the screen
vim.opt.scrolloff = 2 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 5 -- minimum number of lines to keep to the left and right of the cursor

vim.opt.ttimeout = true -- allow a timeout when waiting for a key to complete
vim.opt.ttimeoutlen = 100 -- time in milliseconds that is waited for a key to complete
vim.opt.laststatus = 2 -- always show status line
vim.opt.ttyfast = true -- indicates a fast terminal connection

vim.opt.errorbells = false -- don't ring the bell (beep or screen flash) for error messages
vim.opt.visualbell = true -- use visual bell instead of beeping

vim.opt.spell = false -- disable spell checking
vim.opt.hidden = true -- buffer becomes hidden when it is abandoned
vim.opt.magic = true -- changes the special characters that can be used in search patterns

vim.opt.clipboard = "unnamed" -- use the system clipboard for all yank, delete, change, and put operations

-- change the effect of the 'mksession' command. Each word enables saving and restoring something
vim.opt.sessionoptions = (
  "blank," .. -- empty windows
  "buffers," .. -- hidden and unloaded buffers, not just those in windows
  "curdir," .. -- the current directory
  "folds," .. -- manually created folds, opened/closed folds and local fold options
  "help," .. -- the help window

  "tabpages," .. -- all tab pages; without this only the current tab page is restored
  "winsize," .. -- window sizes
  "terminal," .. -- incluide terminal windows where the command can be restored
  "globals," .. -- global variables that start with an uppercase letter and contain at least one lowercase letter
  "localoptions" -- options and mappings local to a window or buffer
)

vim.opt.wrap = true -- lines longer than the width of the window will wrap and displaying continues on the next line
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false          -- disable folding at startup

vim.opt.splitbelow = true          -- splitting a window will put the new window below the current one
vim.opt.splitright = true          -- splitting a window will put the new window to the right of the current one
vim.opt.title = true               -- When on, the title of the window will be set to the filename

vim.opt.lazyredraw = true          -- screen will not be redrawn while executing macros and registers
vim.opt.whichwrap = "b,s"       -- allow specified keys that move the cursor left/right to move to the previous/next line

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.colorcolumn = "80" -- column that will be highlighted. Useful for aligning text
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it will shift the text each time

vim.opt.isfname:append("@-@") -- allow filenames with literal @ symbol

vim.opt.updatetime = 300 -- write to swapfile after this many ms if no characters are typed
vim.api.nvim_set_option('updatetime', 300) -- set updatetime for CursorHold

vim.opt.wildmenu = false
vim.opt.wildmode = "list:longest:full"
vim.opt.wildignore = (
  ".git,.svn" .. -- version control
  ",*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf" .. -- binary images
  ",*.o,*.obj,*.exe,*.dll,*.manifest" .. -- compiled object files
  ",*.sw?" .. -- vim swap files
  ",.DS_Store" .. -- macos bullshit
  ",*.zip" -- archive files
)

vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"
