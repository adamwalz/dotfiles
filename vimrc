"------------------------------------------------------------------------------
"          FILE: vimrc
"   DESCRIPTION: Configures vim text editor
"        AUTHOR: Adam Walz <adam@adamwalz.net>
"       VERSION: 3.0.0
"------------------------------------------------------------------------------

" set leader key to comma
let mapleader = ','
let maplocalleader = ','

set encoding=utf-8

set nocompatible                     " don't need to be compatible with old vim

" Make vim harder (better to force myself to learn)
set mouse=                           " disable mouse support
" Disabling arrow keys
nnoremap  <up> <nop>
nnoremap  <down> <nop>
nnoremap  <left> <nop>
nnoremap  <right> <nop>
inoremap  <up> <nop>
inoremap  <down> <nop>
inoremap  <left> <nop>
inoremap  <right> <nop>
cnoremap  <up> <nop>
cnoremap  <down> <nop>

set autoindent                       " set auto indent

set shiftround
set shiftwidth=2                     " spaces inserted when using indentation in normal mode
set expandtab                        " use spaces in place of tab character
set tabstop=2                        " width of tab character in columns
set softtabstop=2
set smarttab

set tw=500
set formatoptions=qrn1

set list
set listchars=tab:▸\ ,trail:·,eol:¬  " show extra space characters
set relativenumber                   " show relative line numbers

set backspace=indent,eol,start       " backspace for dummies
set autoread                         " autoread a file when it is changed outside

set complete+=kspell

set showmatch                        " show bracket matches
set matchtime=3

set hlsearch                         " highlight all search matches
set incsearch                        " show search results as I type
set ignorecase                       " ignore case in search
set smartcase                        " pay attention to case when caps are used

set history=1000                     " remember everything
set undolevels=1000                  " remember all undos
set undoreload=10000                 " maximum number of lines to save for undo

set cursorline                       " highlight current line
set ruler                            " show row and column in footer

set scrolljump=5                     " minimum lines scrolled when hitting border
set scrolloff=2                      " minimum lines above/below cursor

set ttimeoutlen=100                  " decrease timeout for faster insert with 'O'
set laststatus=2                     " always show status bar
set ttyfast                          " smoother terminal connection

set noerrorbells
set visualbell                       " enable visual bell (disable audio bell)
set t_vb=

set nospell                          " disable spell checking
set hidden                           " change buffer without saving
set magic                            " better searching

set clipboard=unnamed                " use the system clipboard
set sessionoptions+=tabpages,globals " remember tab names when you save session

set foldlevelstart=0
set foldenable                       " enable code folding

set splitbelow                       " split current window below
set splitright                       " split current window right
set title

set noswapfile                       " don't pollute harddrive with swap files
set lazyredraw
set whichwrap=b,s

filetype off                         " required by vundle

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Colorschemes
Plugin 'sickill/vim-monokai'

" Syntax
Plugin 'Matt-Deacalion/vim-systemd-syntax' " Syntax highlighting for systemd config files
Plugin 'pangloss/vim-javascript'  " Javascript syntax and indent plugins

" Git
Plugin 'tpope/vim-fugitive'

" File Navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'epmatsw/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'wesQ3/vim-windowswap'

" Undolist navigation
Plugin 'sjl/gundo.vim'

" Syntax checking
Plugin 'scrooloose/syntastic'

" Insert Mode
" General
Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'nathanaelkane/vim-indent-guides'

" HTML
Plugin 'mattn/emmet-vim'

" Javascript
Plugin 'marijnh/tern_for_vim'     " Lookup js references under cursor

" Python
Plugin 'tmhedberg/SimpylFold'
Plugin 'klen/python-mode'

" Latex
Plugin 'xuhdev/vim-latex-live-preview'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" put git status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" Use powerline statusbar if available
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/

" set up some custom colors
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=249 ctermfg=20
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" set dark background and color scheme
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme monokai
syntax on

" Allow for cursor beyond last character
set virtualedit=onemore

" Enable wild menu
set wildmenu
set wildmode=list:longest,full
set wildignore=
set wildignore+=.git,.svn                               " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest        " compiled object files
set wildignore+=*.sw?                                   " Vim swap files
set wildignore+=.DS_Store                               " OSX bullshit
set wildignore+=*.zip                                   " zip

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermbg=2   ctermfg=235
  au InsertLeave * hi StatusLine ctermbg=249 ctermfg=20
endif

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Set code folding method and open all folds by defailt
au Syntax javascript,html setlocal foldmethod=syntax
au BufRead * normal zR

" Removes trailing whitespace on save
au FileWritePre    * :%s/\s\+$//e
au FileAppendPre   * :%s/\s\+$//e
au FilterWritePre  * :%s/\s\+$//e
au BufWritePre     * :%s/\s\+$//e

" add :Plain command for converting text to plaintext
command! Plain execute "%s/’/'/ge | %s/[“”]/\"/ge | %s/—/-/ge"

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

" xolox/vim-session
" Don't autosave vim session
let g:session_autosave = 'no'

" kien/ctrlp.vim
let g:ctrlp_map = '<leader>f'
nnoremap <silent> <leader>f :CtrlP<cr>
let g:ctrlp_match_window = 'bottom,order=btt,min:1,max:30,results:10'
let g:ctrlp_working_path_mode = 'ra' " Set root to nearest .git directory
let g:ctrlp_open_new_file = 'v' " Open new files in new vertical split
let g:ctrlp_by_filename = 0 " Search full path by default
let g:ctrlp_switch_buffer = 'e' " Jump to an already opened window instead of creating new instance
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" scrooloose/nerdtree
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$']
map <C-n> :NERDTreeToggle<CR>
augroup nerdtree
  au!
  au StdinReadPre * let s:std_in=1
  au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

" tpope/vim-fugitive (git)
map <leader>b :Gblame<cr>
noremap gws :Gstatus<CR>

" epmatsw/ag.vim (silver searcher)
map <leader>a :Ag!<space>

" Raimondi/delimitMate
au FileType gitcommit let b:delimitMate_autoclose = 0

" ervandew/supertab
let g:SuperTabDefaultCompletionType = '<C-n>'

" valloric/YouCompleteMe
let g:ycm_auto_trigger = 1
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
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" SirVer/ultisnips
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:ycm_use_ultisnips_completer = 1

" scrooloose/syntastic (syntax checking)
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = []
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2 " error window will not automatically open
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['']

" pangloss/vim-javascript
let g:javascript_enable_domhtmlcss = 1 " Enables HTML/CSS syntax highlighting
let b:javascript_fold = 1

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'angularjs,angularui,underscore,jasmine,chai'

" klen/python-mode
let g:pymode_lint_checkers = []

" xuhdev/vim-latex-live-preview
let g:livepreview_previewer = 'open -a Preview'

augroup nodejs_dict " add filetype specific keywords to dictionary
  au!
  au FileType javascript set dictionary+=$HOME/.vim/dict/node.dict " see guileen/vim-node-dict
augroup END

augroup spell_check " autocmd for using spell check by file type
  au!
  au Filetype markdown setlocal spell
  au FileType gitcommit setlocal spell
augroup END

augroup autoload_vimrc " automatically reload vimrc when it's saved
  au!
  " vim automatically sets MYVIMRC environment variable to the full path of the
  " vimrc file.
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

augroup highlight_nbsp " Highlight non breaking spaces (trailing whitespace)
  au!
  au BufEnter * highlight NonBreakingSpace guibg=red
  au BufEnter * :match NonBreakingSpace /\%xa0/
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
