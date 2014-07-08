set nocompatible

if exists("did_load_filetypes")
  filetype off
  filetype plugin indent off
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'

let s:goroot = system("go env GOROOT")
if !v:shell_error
  let g:goroot = substitute(s:goroot, "\n$", "", "")
  let &rtp = &rtp . ',' . g:goroot . "/misc/vim"
endif

filetype plugin indent on
syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set wrapscan

set ch=1

set novisualbell
set t_vb=

set backspace=2

set hidden

set cpoptions=Bces$

set stl=%f\ %M%R\ %l:%v/%L\ %y\ [0x%B]

set laststatus=2

set lazyredraw

set showcmd

set showmode

syntax on

set mousehide

set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

set history=100

set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set virtualedit=all

set wildmenu

" search options
"
set gdefault
set hlsearch
set ignorecase
set smartcase
set incsearch
nnoremap <silent> <cr> :nohlsearch<cr><cr>

"set clipboard+=unnamed

set autoread

let mapleader=","

nmap <silent> ,wa :1,9000bwipeout<cr>

nmap <silent> ,cd :lcd %:h<cr>
nmap <silent> ,md :!mkdir -p %:p:h<cr>

nmap <silent> ,n :nohls<cr>

nmap <silent> ,ww :set invwrap<cr>:set wrap?<cr>

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

nmap <silent> ,bd :bd<cr>

nmap ,x :w<cr>:!chmod 755 %<cr>:e<cr>

nmap <leader>j :bprev<cr>
nmap <leader>k :bnext<cr>

set synmaxcol=2048

set nocursorline
set nocursorcolumn

set nu

set t_Co=256
colorscheme wombat256mod

set nobackup
set nowritebackup
set noswapfile

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

set isfname+=(,)

set encoding=utf-8

if has("win32")
  set backupcopy=yes
  set fencs+=cp1251
  language ctype Russian_Russia.1251
endif

if has("autocmd")
  autocmd FileType go setl ts=4 sts=4 sw=4 et
  if exists("g:goroot")
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType go compiler go
  endif
  
  autocmd FileType python setl ts=4 sts=4 sw=4 et
  autocmd FileType xml setl ts=4 sts=4 sw=4 et
  autocmd FileType java setl ts=4 sts=4 sw=4 et
  autocmd FileType javascript setl ts=4 sts=4 sw=4 et
  autocmd FileType groovy setl ts=4 sts=4 sw=4 et
endif

" Hg
if has("win32")
  autocmd BufNewFile,BufRead hg-editor-*.txt setl fenc=cp1251 tw=79
endif

" Fast save
nmap <f2> :w<cr>
imap <f2> <esc>:w<cr>
vmap <f2> <esc>:w<cr>

" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:bbt,min:1,max:10,results:100'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = {
  \ 'file': '\v(\.(class|jar))$',
  \ 'dir': '\v[\/](' .
  \        '\.git|\.hg|\.svn' . '|' .
  \        '\.cache|\.history|\.lib|dist|target|lib_managed|src_managed|project[\/]boot|project[\/]plugins[\/]project' . '|' .
  \        ')$'
  \ }
let g:ctrlp_open_new_file = 'r'

