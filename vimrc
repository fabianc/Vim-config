set nocompatible   " No Vi-compatibility, changes other options so put it first
set nomodeline     " Security measure, do not apply file specific settings
set encoding=utf-8 " Force utf-8

" Setup plugins
filetype off
set runtimepath+=$HOME/.vim/bundle/neobundle.vim
call neobundle#begin('$HOME/.vim/bundle/')
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'ddollar/nerdcommenter'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ervandew/supertab'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/cscope_macros.vim'
NeoBundle 'vim-scripts/LaTeX-Box'
call neobundle#end()

set ruler
set showcmd
set laststatus=2 " Always show the status bar
set history=100
set dir=$HOME/.vim/swp
set backspace=indent,eol,start
set number
set relativenumber
set showmatch    " Highlight matching parenthesis/brackets/braces
set mouse=a      " Mouse support
if !has('nvim')
  set ttymouse=sgr
end
set scrolloff=3  " Scroll when cursor is this near an edge
set cursorline   " Highlight current line
set spell spelllang=en

set incsearch
set hlsearch
set ignorecase " Ignore case when searching
set smartcase  " Override ignorecase if search string contains uppercase

set expandtab     " Insert spaces instead of tabs
set softtabstop=2 " Insert this many spaces when pressing tab
set shiftwidth=2  " Number of spaces to indent
set tabstop=8     " Show tab as this many spaces

set list
set listchars=tab:»\ 

set wrap
set showbreak=↳\ 
set formatoptions+=lj
set nojoinspaces
set linebreak
set textwidth=79      " Break lines at this width
set colorcolumn=+1    " Show vertical line after the textwidth
set display+=lastline " Show part of a long line if it does not fit

set foldmethod=marker " Fold between {{{ and }}}
" set foldlevel=0
" set foldnestmax=2

set wildmenu
set wildmode=list:longest,full

set splitbelow
set splitright

set tags=./tags;

syntax on
filetype plugin indent on
set novisualbell
set t_vb=
set t_Co=256 " Force 256 colors
set background=light
colorscheme solarized

set omnifunc=syntaxcomplete#Complete

if has("gui_running")
  set guioptions-=T " No toolbar
  set guioptions-=m " No menu
  set guioptions-=t " No tearoff menu
  set guioptions-=e " No gui tabs
  set guioptions-=L " No left scrollbar
  set guioptions-=r " No right scrollbar
  set winaltkeys=no " Do not let the menu steal the alt-key
  set guifont=Ubuntu\ Mono\ 12
endif

let mapleader      = ","
let maplocalleader = "\\"

" Easier ex mode navigation. Mostly taken from :help tcsh-style.
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>p <Up>
cnoremap <Esc>n <Down>
cnoremap <Esc><BS> <C-W>

inoremap <silent> <Del>      <C-O>x
noremap           <leader>w  :update<CR>
noremap  <silent> <leader>nn :set number!<CR>
noremap           <leader>cd :cd %:p:h<CR>
noremap  <silent> <leader>ve :tabe $MYVIMRC<CR>
noremap           <leader>vu :source $MYVIMRC<CR>
nnoremap <silent> <CR>       :nohlsearch<CR><CR>
noremap           <leader>gt :noautocmd vimgrep /TODO\\|FIXME\\|XXX/j %<CR>:cw<CR>

" Plugin mappings
noremap  <silent> <F4>       :VimFilerExplorer -toggle<CR>
nnoremap          <leader>b  :Unite -start-insert buffer<CR>
nnoremap          <leader>f  :Unite -start-insert file_rec/async:!<CR>
nnoremap          <C-p>      :Unite -start-insert file_rec/git:--cached:--others:--exclude-standard<CR>
nnoremap          <leader>y  :Unite -start-insert history/yank<CR>
nnoremap          <leader>l  :Unite -start-insert grep:!<CR>
nnoremap          <leader>gb :Gblame<CR>
nnoremap          <leader>gc :Gcommit<CR>
nnoremap          <leader>gd :Gdiff<CR>
nnoremap          <leader>gs :Gstatus<CR>
nmap              <leader>r  <Plug>NERDCommenterComment
vmap              <leader>r  <Plug>NERDCommenterComment
nmap              <leader>t  <Plug>NERDCommenterUncomment
vmap              <leader>t  <Plug>NERDCommenterUncomment
nmap              <C-_>      <Plug>NERDCommenterToggle
vmap              <C-_>      <Plug>NERDCommenterToggle
nmap              <leader>a= :Tabularize /=<CR>
vmap              <leader>a= :Tabularize /=<CR>
nmap              <leader>a, :Tabularize /,\zs/l0l1<CR>
vmap              <leader>a, :Tabularize /,\zs/l0l1<CR>
nmap              <leader>a: :Tabularize /:\zs/l0l1<CR>
vmap              <leader>a: :Tabularize /:\zs/l0l1<CR>
nmap              <leader>a<space> :Tabularize /\S\ \zs/l0l1<CR>
vmap              <leader>a<space> :Tabularize /\S\ \zs/l0l1<CR>

" Plugin settings
let g:ftplugin_sql_omni_key = "<C-K>"

let g:SuperTabDefaultCompletionType = "context"

let g:airline_powerline_fonts = 0

let g:slime_target = 'tmux'

let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ["flake8"]

let g:vimfiler_as_default_explorer = 1
autocmd FileType vimfiler call s:disable_trailing_whitespace()

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_source_history_yank_enable = 1
let g:unite_prompt="» "
if executable("ag")
  let g:unite_source_grep_command="ag"
  let g:unite_source_grep_default_opts="--nocolor --nogroup --column"
  let g:unite_source_grep_recursive_opt=""
endif
autocmd FileType unite call s:disable_trailing_whitespace()

" Highlight trailing whitespace
" Taken from https://github.com/bronson/vim-trailing-whitespace but changed the
" color to match solarized
highlight ExtraWhitespace ctermbg=darkred guibg=#CC4B43
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:disable_trailing_whitespace()
  autocmd BufWinEnter <buffer> match ExtraWhitespace //
  autocmd InsertLeave <buffer> match ExtraWhitespace //
  autocmd InsertEnter <buffer> match ExtraWhitespace //
endfunction
