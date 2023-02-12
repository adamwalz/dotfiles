-- highlight trailing whitespace in annoying red
vim.cmd[[
  highlight ExtraWhitespace ctermbg=1 guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
]]

local M = {}

-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end


local autoCommands = {
  remove_trailing_whitespace_on_save = {
    {"FileWritePre",    "*", ":%s/\\s\\+$//e"},
    {"FileAppendPre",   "*", ":%s/\\s\\+$//e"},
    {"FilterWritePre",  "*", ":%s/\\s\\+$//e"},
    {"BufWritePre",     "*", ":%s/\\s\\+$//e"},
  },
  -- Set code folding method and open all folds by defailt
  -- autocommand group for setting foldmethod per filetype
  foldmethod = {
    {"Syntax", "javascript,html", "setlocal foldmethod=expr"},
    {"BufWinEnter", "*.py", "setlocal foldexpr=nvim_treesitter#foldexpr() foldmethod=expr"},
    {"BufWinLeave", "*.py", "setlocal foldexpr=nvim_treesitter#foldexpr() foldmethod=expr"},
  },
  -- autocmd for using spell check by file type
  spell_check = {
    {"Filetype", "markdown", "setlocal spell"},
    {"FileType", "gitcommit", "setlocal spell"},
  },
  -- autocommand group for setting filetype by extension
  file_type = {
    {"BufRead,BufNewFile", "*.es6", "setfiletype javascript"},
    {"BufRead,BufNewFile", "*.tex,*.cls", "setfiletype tex"},
    {"BufRead,BufNewFile", "*.template", "setfiletype json"},
    {"BufRead,BufNewFile", "*.env", "setfiletype config"},
    {"BufRead,BufNewFile", "*.flex,*.jflex", "setfiletype jflex"},
  },
  -- autocommand group for setting expandtab by filetype
  epandtabs = {
    {"FileType", "sshconfig", "setlocal noexpandtab"},
    {"FileType", "rust", "setlocal tabstop=4"},
  },
  -- autocommand group for setting update time
  update_time = {
    {"Filetype", "tex", "setl updatetime=1000"}
  },
  -- Show autodiagnostic popup on cursor hover_range
  diagnostic = {
    {"CursorHold", "*", "lua vim.diagnostic.open_float(nil, { focusable = false })"},
  },
  open_folds = {
    {"BufReadPost,FileReadPost", "*", "normal zR"},
  }
}

M.nvim_create_augroups(autoCommands)

if vim.fn.exists('+colorcolumn') then
  print("colorcolumn exists")
  M.nvim_create_augroups({
    colorcolumn = {
      {"FileType gitcommit", "setlocal colorcolumn=50,72"},
      {"FileType python", "setlocal colorcolumn=80,100"},
      {"FileType rust", "setlocal colorcolumn=100"}
    }
  })
end
