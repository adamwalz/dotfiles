"------------------------------------------------------------------------------
"          FILE: nvim/init.vim
"   DESCRIPTION: Configures neovim text editor
"        AUTHOR: Adam Walz <adam@adamwalz.net>
"       VERSION: 1.0.0
"------------------------------------------------------------------------------

" set leader key to comma
let mapleader = ','
let maplocalleader = ','

set encoding=utf-8

set nocompatible   " don't need to be compatible with old vim

set autoindent     " copy indent from current line when starting a new line
set shiftround     " round indent to multiple of 'shiftwidth'. Applies to > and < commands
set shiftwidth=2   " number of spaces to use for each indent
set expandtab      " use spaces to insert a <Tab><Paste>
set tabstop=2      " number of spaces that a <Tab> counts for
set softtabstop=2  " number of spaces that a <Tab> counts for while editing

" When smarttab is on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' or 'softtabstop' are used in other places
set smarttab

set textwidth=500  " maxmimum width of text that is being inserted<Paste>

set formatoptions+=q " allow formatting of comments with gq
set formatoptions+=r " automatically insert the current comment leader after <Enter> in insert mode
set formatoptions+=n " when formatting text, recognize numbered lists
set formatoptions+=1 " don't break a line after a one-letter word
set formatoptions+=j " delete comment character when joining lines

set list " list mode: useful to see the difference between tabs and spaces and for trailing blanks.
set listchars=tab:▸\ ,trail:·,eol:¬  " show extra space characters
set relativenumber                   " show relative line numbers
set number                           " show current line number also

set backspace=indent,eol,start " influences the use of <BS>, <Del> in Insert mode
set autoread                   " autoread a file when it is changed outside of vim

" This option specifies how keyword completion |ins-completion| works when CTRL-P
" or CTRL-N are used.
set complete+=kspell " kspell: use the currently active spell checking `spell`

set showmatch     " when a bracket is inserted, briefly jump to the matching one.
set matchtime=3   " tenths of a second to show the matching paren

set hlsearch            " highlight all search matches
set incsearch           " show search results as they are typed
set ignorecase          " ignore case in search
set smartcase           " override the 'ignorecase' option if the search pattern contains uppercase characters

set history=1000        " record a history of ":" commands
set undolevels=1000     " maximum number of changes that can be undone
set undoreload=10000    " save the whole buffer for undo when reloading it

set cursorline          " highlight the screen line of the cursor with CursorLine
set ruler               " show the line and column number of the cursor position

set scrolljump=5        " minimal number of lines to scroll when the cursor gets off the screen
set scrolloff=2         " minimal number of screen lines to keep above and below the cursor
set sidescrolloff=5     " minimal number of screen columns to keep to the left/right of cursor

set ttimeout            " allow a timeout when waiting for a key to complete
set ttimeoutlen=100     " time in milliseconds that is waited for a key to complete
set laststatus=2        " always show status line
set ttyfast             " indicates a fast terminal connection

set noerrorbells        " don't ring the bell (beep or screen flash) for error messages
set visualbell          " use visual bell instead of beeping
set t_vb=               " no beep or flash is wanted

set nospell             " disable spell checking
set hidden              " buffer becomes hidden when it is abandoned
set magic               " changes the special characters that can be used in search patterns

set clipboard=unnamed   " use the system clipboard for all yank, delete, change, and put operations
set sessionoptions+=tabpages,globals,localoptions " remember tab names when you save session

set foldlevelstart=20   " sets 'foldlevel' when starting to edit another buffer in a window
set foldenable          " when off, all folds are open

set splitbelow          " splitting a window will put the new window below the current one
set splitright          " splitting a window will put the new window to the right of the current one
set title               " When on, the title of the window will be set to the filename

set noswapfile          " don't use a swapfile for the buffer
set lazyredraw          " screen will not be redrawn while executing macros and registers
set whichwrap=b,s       " allow specified keys that move the cursor left/right to move to the previous/next line

" Toggle spelling
nnoremap <leader>s :set invspell<CR>

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --js-completer --java-completer
  endif
endfunction

set rtp+=~/.config/nvim/plugged/vim-plug
runtime plug.vim
call plug#begin('~/.config/nvim/plugged')

" Job runners and make
Plug 'Shougo/vimproc.vim', { 'do': 'make' } " Asynchronous execution library for Vim
Plug 'neomake/neomake' " asynchronously run program instead of the built-in :make to provide an extra layer of makers based on the current file

" Colorschemes
Plug 'sickill/vim-monokai'

" Git
Plug 'tpope/vim-fugitive'
Plug 'octref/RootIgnore' " set 'wildignore' from git repo root or home folder
Plug 'airblade/vim-gitgutter' " shows a git diff in the 'gutter'

" File Navigation
Plug 'ctrlpvim/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag finder
Plug 'rking/ag.vim' " front for ag, A.K.A. the_silver_searcher
Plug 'scrooloose/nerdtree' " presents the filesystem in the form of a tree
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }

" Syntax checking
" Plug 'scrooloose/syntastic'

" Insert Mode
" General
Plug 'tpope/vim-commentary' " Comment out stuff
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets
Plug 'ervandew/supertab' " allows you to use <Tab> for insert completion (:help ins-completion)
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } " fast, as-you-type, fuzzy-search code completion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips' " Code/text Snippets
Plug 'nathanaelkane/vim-indent-guides' " visually display indentation guide

" Code
Plug 'chrisbra/Colorizer', { 'for': ['html', 'css', 'javascript', 'typescript'] } " color css colornames and hex codes
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] } " provides support for expanding abbreviations similar to emmet
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }  " Javascript indentation and syntax support
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' } " Typescript TSServer client
Plug 'Quramy/vim-js-pretty-template', { 'for': ['javascript', 'typescript'] }  " provides syntax highlight for contents in Javascript Template Strings.
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }  " Syntax file and other settings for TypeScript.
Plug 'clausreinke/typescript-tools.vim', { 'for': 'typescript' } " typescript-tools provides access to the TypeScript Language Services via a simple commandline server (tss)
Plug 'klen/python-mode', { 'for': 'python' } " access to libraries including pylint, rope, pydoc, pyflakes, pep8, autopep8, pep257 and mccabe for features like static analysis, refactoring, folding, completion, documentation
Plug 'lambdalisue/vim-pyenv', { 'for': 'python' } " allows you to activate and deactivate the pyenv Python correctly in a live session
Plug 'derekwyatt/vim-scala', { 'for': 'scala' } " Syntax highlighting for Scala
Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'systemd' } " Syntax highlighting for systemd service files
Plug 'google/vim-jsonnet', { 'for': 'jsonnet' } " Syntax highlighting for jsonnet

" Writing
Plug 'tpope/vim-markdown', { 'for': 'markdown' } " Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'reedes/vim-pencil', { 'for': ['text', 'markdown', 'rst', 'tex', 'textile'] } " Vim as a tool for writers
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " lively previewing LaTeX pdf output

call plug#end()

filetype plugin indent on

let g:python2_host_prog = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.7'

set statusline=%F " filename
set statusline+=%m%r%h%w " flags
set statusline+=\ %{fugitive#statusline()} " git branch status
set statusline+=\ [%l,%c]\ [%L,%p%%] " [current line, current col] [num lines, percent to bottom]

" Use powerline statusbar if available
" Note: powerline currently does not work with neovim
" See: https://github.com/powerline/powerline/issues/1287<Paste>
" set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

" set dark background and color scheme
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme monokai
syntax enable

" Override colorscheme with custom colors
" " 0 - black   8 - gray
" " 1 - maroon  9 - red
" " 2 - green  10 - lime
" " 3 - olive  11 - yellow
" " 4 - navy   12 - blue
" " 5 - purple 13 - fuchsia
" " 6 - teal   14 - aqua
" " 7 - silver 15 - white
highlight clear SignColumn
highlight VertSplit                    ctermbg=241
highlight ColorColumn                  ctermbg=237
highlight LineNr                       ctermbg=237 ctermfg=102
highlight CursorLineNr                             ctermfg=11
highlight CursorLine                   ctermbg=237
highlight IncSearch                    ctermbg=186 ctermfg=235
highlight Search       cterm=underline
highlight Visual                       ctermbg=59
highlight clear Pmenu
highlight PmenuSel                     ctermbg=59
highlight SpellBad                     ctermbg=9
highlight Comment                                 ctermfg=243

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.htm
  set t_ut=
endif

" Allow for cursor beyond last character
set virtualedit=onemore

set wildmenu " when 'wildmenu' is on, command-line completion operates in an enhanced mode
" Completion mode that is used for the character specified with 'wildchar'
" list - When more than one match, list all matches
" longest - Complete till longest common string
" fukk - Complete the next full match
set wildmode=list:longest,full
" A file that matches with one of these patterns is ignored when expanding |wildcards
set wildignore=
set wildignore+=.git,.svn                               " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest        " compiled object files
set wildignore+=*.sw?                                   " Vim swap files
set wildignore+=.DS_Store                               " OSX bullshit
set wildignore+=*.zip                                   " zip

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * highlight StatusLine ctermbg=2   ctermfg=235
  au InsertLeave * highlight StatusLine ctermbg=249 ctermfg=20
endif

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Removes trailing whitespace on save
au FileWritePre    * :%s/\s\+$//e
au FileAppendPre   * :%s/\s\+$//e
au FilterWritePre  * :%s/\s\+$//e
au BufWritePre     * :%s/\s\+$//e

" Set code folding method and open all folds by defailt
augroup foldmethod " autocommand group for setting foldmethod per filetype
  au!
  au Syntax javascript,html setlocal foldmethod=syntax
  au BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
  au BufWinLeave *.py setlocal foldexpr< foldmethod<
  au BufRead * normal zR
augroup END

" line splitting
imap <C-c> <CR><Esc>O

" fast saving
nnoremap <leader>w :w!<cr>

" faster movement
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" just use CTRL instead of CTRL-w to switch between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" unmap ex mode: 'Type visual to go into Normal mode.'
nnoremap Q <nop>

" map . in visual mode
vnoremap . :norm.<cr>

" toggle spell check with <F5>
map <F5> :setlocal spell! spelllang=en_us<cr>
imap <F5> <ESC>:setlocal spell! spelllang=en_us<cr>

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
  augroup colorcolumn
    au!
    au FileType gitcommit setlocal colorcolumn=50,72
    au FileType python setlocal colorcolumn=80,100
  augroup END
endif

" kien/ctrlp.vim
let g:ctrlp_map = '<leader>f'
nnoremap <silent> <leader>f :CtrlP<cr>
let g:ctrlp_match_window = 'bottom,order=btt,min:1,max:30,results:10' " result position and ordering
let g:ctrlp_working_path_mode = 'ra' " set root to nearest .git directory
let g:ctrlp_open_new_file = 'v' " open new files in new vertical split
let g:ctrlp_by_filename = 0 " search full path by default
let g:ctrlp_switch_buffer = 'e' " jump to an already opened window instead of creating new instance
let g:ctrlp_user_command = 'rg %s -l --nocolor -g ""' " specify an external tool for search instead of Vim's globpath()

" scrooloose/nerdtree
let NERDTreeRespectWildIgnore = 1
let NERDTreeQuitOnOpen = 1 " the NERDTree window will close after opening a file
let NERDTreeIgnore = [] " specify which files the NERD tree should ignore
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
augroup nerdtree
  au!
  au StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " open NERDTree automatically if no files were opened"
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif " open NERDTree automatically when opening a directory
  au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if the only window left open is a NERDTree
augroup END

" tpope/vim-fugitive (git)
map <leader>b :Gblame<cr>
noremap gws :Gstatus<CR>

" rking/ag.vim (the silver searcher)
let g:ag_prg="/usr/local/bin/rg --vimgrep" " Use ripgrep instead of ag
let g:ag_working_path_mode="r"
map <leader>a :Ag!<space>

" Raimondi/delimitMate
au FileType gitcommit let b:delimitMate_autoclose = 0

" valloric/YouCompleteMe
let g:ycm_auto_trigger = 1 "  YCM's identifier completer (the as-you-type popup)
let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_filetype_blacklist = {
      \ 'markdown' : 1,
      \ 'text' : 1,
      \}
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1
      \}
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python2'
nmap <leader>gt :YcmCompleter GetType <CR>
nmap <leader>gtt :YcmCompleter GoToType <CR>
nmap <leader>gd :YcmCompleter GoToDefinition <CR>
nmap <leader>d :YcmCompleter GetDoc <CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources={}
let g:deoplete#sources._=['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
let g:deoplete#omni#input_patterns={}
let g:deoplete#omni#input_patterns.scala='[^. *\t]\.\w*'

" SirVer/ultisnips
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:ycm_use_ultisnips_completer = 1

" scrooloose/syntastic (syntax checking)
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_always_populate_loc_list = 1  " Have syntastic to always stick any detected errors into the location list
" let g:syntastic_auto_loc_list = 2 " Automatically open/close location list
" let g:syntastic_enable_signs = 1  " use the `:sign` interface to mark syntax errors
" let g:syntastic_bash_checkers = ['shellcheck']
" let g:syntastic_html_checkers = []
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_python_checkers=['pylint']
" let g:syntastic_typescript_checkers=['tslint']
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

"Linting with neomake
let g:neomake_sbt_maker = {
      \ 'exe': 'sbt',
      \ 'args': ['-Dsbt.log.noformat=true', 'compile'],
      \ 'append_file': 0,
      \ 'auto_enabled': 1,
      \ 'output_stream': 'stdout',
      \ 'errorformat':
          \ '%E[%trror]\ %f:%l:\ %m,' .
            \ '%-Z[error]\ %p^,' .
            \ '%-C%.%#,' .
            \ '%-G%.%#'
     \ }
let g:neomake_scala_enabled_makers = ['sbt']
let g:neomake_verbose=3

" Neomake on text change
autocmd InsertLeave,TextChanged * update | Neomake! sbt

" chrisbra/Colorizer
let g:colorizer_auto_filetype='css,html'

" pangloss/vim-javascript
let g:javascript_enable_domhtmlcss = 1 " Enables HTML/CSS syntax highlighting
let b:javascript_fold = 1

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'angularjs,angularui,underscore,jasmine,chai'

" google/jsonnet
let g:jsonnet_fmt_on_save = 0

" tmhedberg/SimpylFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_import = 1

" klen/python-mode
let g:pymode_lint_checkers = [] " Let syntastic handle linting

" xuhdev/vim-latex-live-preview
let g:livepreview_previewer = 'open -a Preview'

augroup nodejs_dict " add filetype specific keywords to dictionary
  au!
  au FileType javascript set dictionary+=$HOME/.vim/dict/node.dict " see guileen/vim-node-dict
augroup END

augroup js_template_string " Set JS template strings to html
  au!
  autocmd FileType typescript JsPreTmpl html
  autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim
augroup END

augroup spell_check " autocmd for using spell check by file type
  au!
  au Filetype markdown setlocal spell
  au FileType gitcommit setlocal spell
augroup END

augroup autoload_vimrc " automatically reload vimrc when it's saved
  au!
  " vim automatically sets MYVIMRC environment variable to the full path of the vimrc file.
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

augroup file_type " autocommand group for setting filetype by extension
  au!
  au BufRead,BufNewFile *.es6 setfiletype javascript
  au BufRead,BufNewFile *.tex,*.cls setfiletype tex
  au BufRead,BufNewFile *.template setfiletype json
  au BufRead,BufNewFile *.env setfiletype config
augroup END

augroup epandtabs " autocommand group for setting expandtab by filetype
  au!
  au FileType sshconfig setlocal noexpandtab
augroup END

augroup update_time " autocommand group for setting update time
  au!
  au Filetype tex setl updatetime=1000
augroup END
