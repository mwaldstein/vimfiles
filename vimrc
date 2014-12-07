set nocompatible  " use VIM settings, not vi
filetype off      " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim " set the runtime to include Vundle
call vundle#begin()               " initialize

Plugin 'gmarik/Vundle.vim'        " let Vundle manage itself
Plugin 'kien/ctrlp.vim'           " ctrlp
Plugin 'bling/vim-airline'        " airline
Plugin 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'   " better js syntax

call vundle#end()

"-------------------------------------------------------------------------------
" Avoid some security exploits
"-------------------------------------------------------------------------------
set modelines=0

"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
syntax    on            
"
" Platform specific items:
" - central backup directory (has to be created)
" - default dictionary
" Uncomment your choice.  
if  has("win16") || has("win32") || has("win64") || has("win95")
"
"  runtime mswin.vim
"  set backupdir =$VIM\vimfiles\backupdir
"  set dictionary=$VIM\vimfiles\wordlists/german.list
  set directory=$TMP,.
  set gfn=Consolas:h9
else
"  set dictionary=$HOME/.vim/wordlists/german.list,$HOME/.vim/wordlists/english.list
  set dictionary=$HOME/.vim/wordlists/english.list
endif

"-------------------------------------------------------------------------------
" Tab settings
"-------------------------------------------------------------------------------
set shiftwidth=2                " number of spaces to use for each step of indent
set tabstop=2                   " number of spaces that a <Tab> counts for
set softtabstop=2               " 
set expandtab                   " tab = spaces

"-------------------------------------------------------------------------------
" Title Stettings
"-------------------------------------------------------------------------------
set title                       " change the terminal title
set titlestring=vim(%t)
if &term == "screen-bce" || &term == "screen"
  set t_ts=k
  set t_fs=\
endif

"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set nobackup                    " don't keep a backup file
set noswapfile                  " not needed with a lot of memory 
                                " http://blog.sanctum.geek.nz/vim-annoyances/
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=                      " disable the use of the mouse
set wrap                        " wrap lines
set nonumber                    " don't show line numbers - we'd like to show relative.
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set smartindent                 " smart autoindenting when starting a new line
set visualbell                  " visual bell instead of beeping
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'

set encoding=utf-8
set scrolloff=3                 " Min number of screen lines to keep above/below cursor
set showmode                    " Put message with current mode
set showcmd                     " show command in last line
set hidden                      " don't unload hidden buffers
set ttyfast                     " smooths redrawing due to more characters sent along

set wildmenu                    " command-line completion in an enhanced mode
set wildmode=list:longest
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions

set laststatus=2                " Always show status line

set textwidth=79                " wrap at line 79
set formatoptions=qrn1          " softwrap?

" vim 7.3 specific options
if v:version >= 730
  set colorcolumn=85              " mark column 85 to indicate wrapping
endif

" vim 7.0.3 specific options
if v:version >= 703
  set relativenumber              " make line numbers relative to current line
else
  set number                      " fall back on just showing numbers
endif

set list                        " display hidden characters

set splitbelow                  " set splits happen in a more logical manner
set splitright                  " new splits in a reasonable place

"-------------------------------------------------------------------------------
"  highlight paired brackets
"-------------------------------------------------------------------------------
highlight MatchParen ctermbg=blue guibg=lightyellow

"-------------------------------------------------------------------------------
" Search/Replace Settings
"-------------------------------------------------------------------------------
" make search always use regex format
nnoremap / /\v
vnoremap / /\v

set ignorecase                  " most of the time, case doesn't matter
set smartcase                   " except when the search contains case

set showmatch
set hlsearch                    " highlightthe last used search pattern
set incsearch                   " do incremental searching

nnoremap <leader><space> :noh<cr>  " easy clear out search
nnoremap <tab> %
vnoremap <tab> %
set gdefault                    " substitutions are always global

"-------------------------------------------------------------------------------
" navigation
"-------------------------------------------------------------------------------
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"#nnoremap j gj
"#nnoremap k gk
"-------------------------------------------------------------------------------
" Window Navigation
"-------------------------------------------------------------------------------
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"-------------------------------------------------------------------------------
" Remove some annoyances
"-------------------------------------------------------------------------------
" avoid entering ex mode when recording a macro
nnoremap Q <nop>
" don't need to bring up man pages...
nnoremap K <nop>

"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"     F1  -  Same as escape to avoid bringing up help
"-------------------------------------------------------------------------------
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
 noremap  <silent> <s-tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <s-tab>  <C-C>:if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q (KDE): Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nnoremap  <C-q>    :wqall<CR>
"
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"
"-------------------------------------------------------------------------------
" ctrlp
"-------------------------------------------------------------------------------
"
let g:ctrlp_dotfiles = 0
"
"

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv
"
" " make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

set t_Co=256
let g:solarized_termcolors=256
set background=light
colorscheme solarized
