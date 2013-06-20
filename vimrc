set nocompatible

call pathogen#infect()

filetype on
filetype plugin on
filetype indent on

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

set stl=%f\ %m\ %r%\{fugitive#statusline()}\ Line:%l/%L\ [%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

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

set hlsearch

set incsearch

set ignorecase

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
  autocmd FileType python setl ts=4 sts=4 sw=4 et
  autocmd FileType xml setl ts=4 sts=4 sw=4 et
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

" NERD Tree
nmap <f3> :NERDTreeToggle<cr>
imap <f3> <esc>:NERDTreeToggle<cr>
vmap <f3> <esc>:NERDTreeToggle<cr>

