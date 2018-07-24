set nocompatible  " use VIM settings, not vi
filetype off      " required for vundle

if has("win32") || has("win16")
  set rtp+=~/vimfiles/bundle/Vundle.vim " set the runtime to include Vundle
else
  set rtp+=~/.vim/bundle/Vundle.vim " set the runtime to include Vundle
endif
call vundle#begin()               " initialize
Plugin 'VundleVim/Vundle.vim'        " let Vundle manage itself
Plugin 'tpope/vim-sensible'       " A lot of good defaults
Plugin 'kien/ctrlp.vim'           " ctrlp
" COLORS
Plugin 'altercation/vim-colors-solarized'
Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'

Plugin 'jalvesaq/Nvim-R'          " R tools
Plugin 'christoomey/vim-tmux-navigator'          " Screen to simulate split shell
Plugin 'w0rp/ale'                 " Syntax checking async
Plugin 'tpope/vim-vinegar'        " Folder navigation
Plugin 'sheerun/vim-polyglot'     " syntax support for everything
Plugin 'vim-pandoc/vim-pandoc-syntax' "needed to make RMD syntax highlighting work
Plugin 'junegunn/vim-easy-align'  " Like it says on the tin
Plugin 'joereynolds/SQHell.vim'   " sql manager
"Plugin 'dbext.vim'                " sql manager
Plugin 'jonathanfilip/vim-dbext'   " sql manager
"Plugin 'pangloss/vim-javascript'  " better js syntax
"Plugin 'posva/vim-vue'            " vue file syntax
Plugin 'itchyny/lightline.vim'
Plugin 'maximbaz/lightline-ale'
call vundle#end()
filetype plugin indent on    " required

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
" Various settings
"-------------------------------------------------------------------------------
set nobackup                    " don't keep a backup file
set nowritebackup               " Write direct to file rather than new and rename
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

tnoremap <silent> <C-h> <C-w>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-j> <C-w>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-w>:TmuxNavigateUp<cr>
tnoremap <silent> <C-l> <C-w>:TmuxNavigateRight<cr>
tnoremap <silent> <C-\> <C-w>:TmuxNavigatePrevious<cr>

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
" Source: http://vim.wikia.com/wiki/Switch_color_schemes
" Very modified
let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
"let s:swcolors = map(paths, 'fnamemodify(v:val, ":t:r")')
let s:swcolors = ['solarized8', 'solarized8_low', 'solarized8_high',
                 \'solarized8_flat', 'gruvbox' ]
let s:swskip = [ '256-jungle', '3dglasses', 'calmar256-light', 'coots-beauty-256', 'grb256' ]
let s:swback = 0    " background variants light/dark was not yet switched
let s:swindex = 0

function! SwitchColor(swinc)
  " if have switched background: dark/light
  if (s:swback == 1)
    let s:swindex += a:swinc
  endif
  let i = s:swindex % len(s:swcolors)

  " in skip list
  if (index(s:swskip, s:swcolors[i]) != -1)
    return SwitchColor(a:swinc)
  endif

  if (s:swback == 1)
    if (&background == "light")
      execute "set background=dark"
    else
      execute "set background=light"
    endif
  endif
  execute "colorscheme " . s:swcolors[i]

  " roll back if background is not supported
  if (!exists('g:colors_name'))
    "execute "colorscheme " . s:swcolors[i]
    "return SwitchColor(a:swinc)
  endif

  let s:swback = (s:swback == 1 ? 0 : 1)

  " show current name on screen. :h :echo-redraw
  redraw
  execute "colorscheme"
endfunction

 map <F11>        :call SwitchColor(1)<CR>
imap <F11>   <Esc>:call SwitchColor(1)<CR>

 map <S-F11>      :call SwitchColor(-1)<CR>
imap <S-F11> <Esc>:call SwitchColor(-1)<CR>

nnoremap <leader>]] :call SwitchColor(1)<CR>
nnoremap <leader>][ :call SwitchColor(-1)<CR>

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
" TMux/title integration
"-------------------------------------------------------------------------------
" title settings for tmux
if has("win32") || has("win16")
else
  " autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '<" . expand("%:t") . ">'")
  autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * let &titlestring = 'vim:' . expand("%:t")
  autocmd VimLeave * set notitle

  set t_ts=k
  set t_fs=\
  set title

endif
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
" COLORS --------------------------------------
set termguicolors
set background=dark
let g:solarized_termtrans = 0
colorscheme solarized8

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
" let g:netrw_hide = 1 " hide dotfiles by default
"let g:netrw_banner = 0 " Turn off banner
""" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

"-----------------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------------
autocmd FileType markdown setlocal spell
autocmd FileType rmarkdown setlocal spell

"-----------------------------------------------------------------------------------
" Vim-R
"-----------------------------------------------------------------------------------
"let R_in_buffer = 0
"let R_applescript = 0
"let R_tmux_split = 1
let R_assign = 3

let R_parenblock = 0 " Don't try to match parens when sending lines

let r_syntax_folding = 1

let rrst_syn_hl_chunk = 1
let rmd_syn_hl_chunk = 1

autocmd FileType r setlocal shiftwidth=2

"-----------------------------------------------------------------------------------
" Easy Align
"-----------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------------
" Vim-Vue
"-----------------------------------------------------------------------------------
let g:vue_disable_pre_processors=1 " Speeds up slowdown from vim-vue checking for everything
autocmd FileType vue syntax sync fromstart " avoid syntax highlighting getting confused

"-----------------------------------------------------------------------------------
" dbext
"-----------------------------------------------------------------------------------
let g:dbext_default_profile_localSqlite = 'type=SQLITE:dbname=@askg'
let g:dbext_default_job_enable = 1

"-----------------------------------------------------------------------------------
" ALE Syntax check config
"-----------------------------------------------------------------------------------
let g:ale_javascript_eslint_use_global = 0 " Force use of local eslint
let g:ale_sign_column_always = 1           " always keep the gutter open
" Map keys to use wrapping.
nmap <silent> <Leader>n <Plug>(ale_previous_wrap)
nmap <silent> <Leader>p <Plug>(ale_next_wrap)

"-----------------------------------------------------------------------------------
" Lightline + Lightline-ale
"-----------------------------------------------------------------------------------
" Avoid duplicate mode displays
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'solarized'
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [
      \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ]
      \ ] }
