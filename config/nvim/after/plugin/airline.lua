local airline_available, airline = pcall(require, "airline")

if airline_available then
  vim.g.airline_symbols.linenr = " ㏑:"
  vim.g.airline_symbols.modified = '+'
  vim.g.airline_symbols.whitespace = '☲'
  vim.g.airline_symbols.branch = 'ᚠ'
  vim.g.airline_symbols.ellipsis = '...'
  vim.g.airline_symbols.paste = 'PASTE'
  vim.g.airline_symbols.maxlinenr = '☰'
  vim.g.airline_symbols.readonly = '⊝'
  vim.g.airline_symbols.spell = 'SPELL'
  vim.g.airline_symbols.space = ' '
  vim.g.airline_symbols.dirty = '!'
  vim.g.airline_symbols.colnr = ' ℅:'
  vim.g.airline_symbols.keymap = 'Keymap:'
  vim.g.airline_symbols.crypt = '🔒'
  vim.g.airline_symbols.notexists = 'Ɇ'

  -- Section A
  -- displays the mode + additional flags like crypt/spell/paste (INSERT)
  vim.g.airline_section_a = '%#__accent_bold#%{airline#util#wrap(airline#parts#mode(),0)}%#__restore__#%{airline#util#append(airline#parts#crypt(),0)}%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append(airline#extensions#keymap#status(),0)}%{airline#util#append(airline#parts#spell(),0)}%{airline#util#append("",0)}%{airline#util#append("",0)}%{airline#util#append(airline#parts#iminsert(),0)}'

  -- Section B
  -- Environment status (VCS information - branch, hunk summary (master), battery level)
  vim.g.airline_section_b = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),100)}%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'

  -- Section C
  -- filename + read-only flag (~/.vim/vimrc RO)
  vim.g.airline_section_c = '%<%<%{airline#extensions#fugitiveline#bufname()}%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%#__accent_bold#%#__restore__#%#__accent_bold#%#__restore__#'

  -- Section X
  -- filetype (vim)
  vim.g.airline_section_x = '%#__accent_bold#%#__restore__#%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}'

  -- Section Y
  -- file encoding[fileformat] (utf-8[unix])
  vim.g.airline_section_y = '%{airline#util#wrap(airline#parts#ffenc(),0)}'

  -- Section Z
  -- current position in the file
  vim.g.airline_section_z = '%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#%{g:airline_symbols.colnr}%v%#__restore__#'

  -- Section [...]
  -- additional sections (warning/errors/statistics) from external plugins (e.g. YCM, syntastic, ...)
  vim.g.airline_section_gutter = '%='
  vim.g.airline_section_error = '%{airline#util#wrap(airline#extensions#nvimlsp#get_error(),0)}'
  vim.g.airline_section_warning = '%{airline#util#wrap(airline#extensions#nvimlsp#get_warning(),0)}%{airline#util#wrap(airline#extensions#whitespace#check(),0)}'
end
