set nocompatible  " use VIM settings, not vi
filetype off      " required for vundle

if has("win32") || has("win16")
  set rtp+=~/vimfiles/bundle/Vundle.vim " set the runtime to include Vundle
else
  set rtp+=~/.vim/bundle/Vundle.vim " set the runtime to include Vundle
endif
call vundle#begin()               " initialize
Plugin 'gmarik/Vundle.vim'        " let Vundle manage itself
Plugin 'tpope/vim-sensible'       " A lot of good defaults
Plugin 'kien/ctrlp.vim'           " ctrlp
Plugin 'altercation/vim-colors-solarized'
Plugin 'jalvesaq/Nvim-R'          " R tools
Plugin 'christoomey/vim-tmux-navigator'          " Screen to simulate split shell
Plugin 'w0rp/ale'                 " Syntax checking async
Plugin 'tpope/vim-vinegar'        " Folder navigation
Plugin 'sheerun/vim-polyglot'     " syntax support for everything
"Plugin 'pangloss/vim-javascript'  " better js syntax
"Plugin 'posva/vim-vue'            " vue file syntax
call vundle#end()

"
" Platform specific items:
" - central backup directory (has to be created)
" - default dictionary
" Uncomment your choice.  
if  has("win16") || has("win32") || has("win64") || has("win95")
"
"  runtime mswin.vim
  set directory=$TMP,.
  set gfn=Consolas:h9
else
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

"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set nobackup                    " don't keep a backup file
set noswapfile                  " not needed with a lot of memory 
                                " http://blog.sanctum.geek.nz/vim-annoyances/
set browsedir=current           " which directory to use for the file browser
set mouse=                      " disable the use of the mouse
set wrap                        " wrap lines
set nonumber                    " don't show line numbers - we'd like to show relative.
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set smartindent                 " smart autoindenting when starting a new line
set visualbell                  " visual bell instead of beeping

set encoding=utf-8
set scrolloff=4                 " Min number of screen lines to keep above/below cursor
set showmode                    " Put message with current mode
set showcmd                     " show command in last line
set hidden                      " don't unload hidden buffers
set ttyfast                     " smooths redrawing due to more characters sent along

set textwidth=79                " wrap at line 79

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

"-------------------------------------------------------------------------------
" Better split navigation Navigation
"-------------------------------------------------------------------------------
set splitbelow                  " set splits happen in a more logical manner
set splitright                  " new splits in a reasonable place

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
"     F11  -  Toggle background
"-------------------------------------------------------------------------------
call togglebg#map("<F11>")

"-------------------------------------------------------------------------------
"     F12  -  Paste toggle
"-------------------------------------------------------------------------------
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
"nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>
"set showmode

"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
" if has("autocmd")
"   autocmd BufEnter * :lchdir %:p:h
" endif
"
"===================================================================================
" builtin searching tweaks
"===================================================================================
set wildmenu                    " command-line completion in an enhanced mode
set wildmode=list:longest
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
" git ignore
set wildignore+=*/.git/**/*
set wildignore+=*/node_modules/*,*/vendor/*
set wildignore+=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions

" built in searching stuff
set path=.,**
set wildignorecase
set wildmenu                    " command-line completion in an enhanced mode
set wildmode=list:longest

"-------------------------------------------------------------------------------
" TMux integration
"-------------------------------------------------------------------------------
" title settings for tmux
if has("win32") || has("win16")
else
  autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '<" . expand("%:t") . ">'")
  autocmd VimLeave * call system("tmux rename-window 'tmux'")
endif
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
" COLORS --------------------------------------
set t_Co=256
set t_ut=   " Disables background redraw
"let g:solarized_termcolors=256
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

"-------------------------------------------------------------------------------
" ctrlp
"-------------------------------------------------------------------------------
let g:ctrlp_dotfiles = 0
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 'ra'

"-----------------------------------------------------------------------------------
" Foldin
"-----------------------------------------------------------------------------------
set foldmethod=syntax
set foldlevelstart=2

"-----------------------------------------------------------------------------------
" NetRW
"-----------------------------------------------------------------------------------
let g:netrw_liststyle = 1 " Detail View
let g:netrw_sizestyle = "H" " Human-readable file sizes
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_hide = 1 " hide dotfiles by default
"let g:netrw_banner = 0 " Turn off banner
""" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

"-----------------------------------------------------------------------------------
" Vim-R
"-----------------------------------------------------------------------------------
let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1
let R_assign = 3

"-----------------------------------------------------------------------------------
" ALE Syntax check config
"-----------------------------------------------------------------------------------
let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_use_global = 0 " Force use of local eslint
let g:ale_sign_column_always = 1           " always keep the gutter open
" Map keys to use wrapping.
nmap <silent> <Leader>n <Plug>(ale_previous_wrap)
nmap <silent> <Leader>p <Plug>(ale_next_wrap)

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
      \   '%dW %dE',
      \   all_non_errors,
      \   all_errors
  \)
endfunction


" For a more fancy ale statusline
function! ALEGetOk()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return '•'
  else
    return ''
  endif
endfunction

function! ALEGetError()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  else
    let l:e_w = split(l:res)
    if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
      return '•' . matchstr(l:e_w[0], '\d\+')
    else
      return ''
    endif
  endif
endfunction

function! ALEGetWarning()
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  if l:all_non_errors == 0
    return ''
  else
    return '•' . l:all_non_errors
  endif
endfunction

hi SignColumn ctermbg=0
hi AleGutterOk ctermbg=0 ctermfg=2
hi AleGutterWarning ctermbg=0 ctermfg=9
hi AleGutterError ctermbg=0 ctermfg=1

set statusline=%{LinterStatus()}

set statusline=
set statusline+=%#CursorColumn#
set statusline+=%#AleGutterError#
set statusline+=%{ALEGetError()}
set statusline+=\ %#AleGutterWarning#
set statusline+=%{ALEGetWarning()}
set statusline+=\ %#AleGutterOk#
set statusline+=%{ALEGetOk()}
set statusline+=%#CursorColumn#
"set statusline+=%{LinterStatus()}
"set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
