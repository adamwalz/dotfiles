"------------------------------------------------------------------------------
"          FILE: vimrc
"   DESCRIPTION: Configures vim text editor
"        AUTHOR: Adam Walz <adam@adamwalz.net>
"       VERSION: 2.0.0
"------------------------------------------------------------------------------

" set leader key to comma
let mapleader = ','
let maplocalleader = ','

set encoding=utf-8

set nocompatible                  " don't need to be compatible with old vim

" Make vim harder (better to force myself to learn)
set mouse=                        " disable mouse support
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

set autoindent                    " set auto indent

set shiftround
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set tabstop=2                     " set indent to 2 spaces
set softtabstop=2
set smarttab

set tw=500
set formatoptions=qrn1

set list
set listchars=tab:»·,trail:·      " show extra space characters
set relativenumber                " show relative line numbers

set backspace=indent,eol,start    " backspace for dummies
set autoread                      " autoread a file when it is changed outside

set complete+=kspell

set showmatch                     " show bracket matches
set matchtime=3

set hlsearch                      " highlight all search matches
set incsearch                     " show search results as I type
set ignorecase                    " ignore case in search
set smartcase                     " pay attention to case when caps are used

set history=1000                  " remember everything
set undolevels=1000               " remember all undos
set undoreload=10000              " maximum number of lines to save for undo

set cursorline                    " highlight current line
set ruler                         " show row and column in footer

set scrolljump=5                  " minimum lines scrolled when hitting border
set scrolloff=2                   " minimum lines above/below cursor

set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set laststatus=2                  " always show status bar
set ttyfast                       " smoother terminal connection

set noerrorbells
set visualbell                    " enable visual bell (disable audio bell)
set t_vb=

set nospell                       " disable spell checking
set hidden                        " change buffer without saving
set magic                         " better searching

set clipboard=unnamed             " use the system clipboard
set sessionoptions+=tabpages,globals " remember tab names when you save session

set foldlevelstart=0
set foldenable                    " enable code folding

set splitbelow                    " split current window below
set splitright                    " split current window right
set title

set noswapfile                    " don't pollute harddrive with swap files
set lazyredraw
set whichwrap=b,s

filetype off                      " required by vundle

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Colorschemes
Plugin 'sickill/vim-monokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'sjl/badwolf'

" Git
Plugin 'tpope/vim-fugitive'

" Tmux
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'

" File Navigation
Plugin 'kien/ctrlp.vim'
Plugin 'epmatsw/ag.vim'
Plugin 'scrooloose/nerdtree'

" Syntax checking
Plugin 'scrooloose/syntastic'

" Sessions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Tabs
Plugin 'gcmt/taboo.vim'

" Insert Mode
" General
Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'nathanaelkane/vim-indent-guides'

" HTML
Plugin 'mattn/emmet-vim'

" Javascript
Plugin 'pangloss/vim-javascript'  " Javascript syntax and indent plugins
Plugin 'marijnh/tern_for_vim'     " Lookup js references under cursor
Plugin 'othree/yajs.vim'          " Javascript syntax highlighting
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'burnettk/vim-angular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" put git status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" set up some custom colors
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
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
set background=dark
colorscheme monokai
syntax on

" Allow for cursor beyond last character
set virtualedit=onemore

" Enable wild menu
set wildmenu
set wildmode=list:longest,full
set wildignore+=.git,.svn                         " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest  " compiled object files
set wildignore+=*.sw?                             " Vim swap files
set wildignore+=*.DS_Store                        " OSX bullshit
set wildignore+=*.zip                             " zip

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Set code folding method and open all folds by defailt
autocmd Syntax javascript,html setlocal foldmethod=syntax
autocmd Syntax javascript,html normal zR

" Removes trailing whitespace on save
autocmd FileWritePre    * :%s/\s\+$//e
autocmd FileAppendPre   * :%s/\s\+$//e
autocmd FilterWritePre  * :%s/\s\+$//e
autocmd BufWritePre     * :%s/\s\+$//e

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
  autocmd FileType gitcommit setlocal colorcolumn=72
endif

" xolox/vim-session
" Don't autosave vim session
let g:session_autosave = 'no'

" kien/ctrlp.vim
let g:ctrlp_map = '<leader>f'
nnoremap <silent> <leader>f :CtrlP<cr>
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = {'dir': 'dist'}

" use silver searcher for ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" scrooloose/nerdtree
let NERDTreeQuitOnOpen=1
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" tpope/vim-fugitive (git)
map <leader>b :Gblame<cr>
map <leader>l :!clear && git log -p %<cr>
map <leader>d :!clear && git diff %<cr>

" epmatsw/ag.vim (silver searcher)
map <leader>a :Ag!<space>

" Raimondi/delimitMate
au FileType gitcommit let b:delimitMate_autoclose = 0

" SirVer/ultisnips
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabCrMapping = 0
let g:UtilSnipsExpandTrigger = '<tab>'
let g:UtilSnipsJumpForwardTrigger = '<tab>'
let g:UtilSnipsJumpBackwardTrigger = '<s-tab>'
let g:ycm_key_list_select_completion = ['<C-j', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k', '<C-p>', '<Up>']

" scrooloose/syntastic (syntax checking)
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers = []
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['']

" pangloss/vim-javascript
let g:javascript_enable_domhtmlcss = 1 " Enables HTML/CSS syntax highlighting
let b:javascript_fold = 1

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'angularjs,angularui,underscore,jasmine,chai'

augroup spell_check
  au!
  au BufRead,BufNewFile *.md setlocal spell
  au FileType gitcommit setlocal spell
augroup END

augroup autoload_vimrc
  au!
  " automatically reload vimrc when it's saved
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

augroup highlight_nbsp
  au!
  au BufEnter * highlight NonBreakingSpace guibg=red
  au BufEnter * :match NonBreakingSpace /\%xa0/
augroup END

augroup file_type
  au!
  au BufRead,BufNewFile *.es6 setfiletype javascript
augroup END
