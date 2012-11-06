"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  suggestion for a personal configuration file ~/.vimrc
"       AUTHOR:  Dr.-Ing. Fritz Mehner
"      VERSION:  1.0
"      CREATED:  23.05.2008
"     REVISION:  $Id: customization.vimrc,v 1.9 2011/05/05 17:49:18 mehner Exp $
"===================================================================================
"
"===================================================================================
" GENERAL SETTINGS
"===================================================================================
" Startup pathogen

call pathogen#infect()

"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
set nocompatible
set background=dark
set t_Co=256

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
set number                      " show line numbers
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
  set relativenumber              " make line numbers relative to current line
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
"     F4  -  show tag under curser in the preview window (tagfile must exist!)
"     F6  -  list all errors           
"     F7  -  display previous error
"     F8  -  display next error   
"-------------------------------------------------------------------------------
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

noremap   <silent> <F4>         :execute ":ptag ".expand("<cword>")<CR>
noremap   <silent> <F6>         :cclose<CR>
noremap   <silent> <F7>         :cprevious<CR>
noremap   <silent> <F8>         :cnext<CR>
"
inoremap  <silent> <F4>    <C-C>:execute ":ptag ".expand("<cword>")<CR>
inoremap  <silent> <F6>    <C-C>:cclose<CR>
inoremap  <silent> <F7>    <C-C>:cprevious<CR>
inoremap  <silent> <F8>    <C-C>:cnext<CR>
"
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
"-------------------------------------------------------------------------------
" perl-support.vim
"-------------------------------------------------------------------------------
"            
" --empty --
"
"-------------------------------------------------------------------------------
" plugin taglist.vim : toggle the taglist window
" plugin taglist.vim : define the tag file entry for Perl
"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
 noremap <silent> <F11>       :TlistToggle<CR>
inoremap <silent> <F11>  <C-C>:TlistToggle<CR>
"
let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
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

color lucius
