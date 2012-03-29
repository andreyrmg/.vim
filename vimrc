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

set cpoptions=ces$

set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

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

set clipboard+=unnamed

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
highlight lCursor guifg=NONE guibg=Cyan

if has("win32")
  set fencs="cp1251,utf-8"
  set iskeyword=@,a-z,A-Z,48-57,_,128-175,192-255
  set isident=@,48-57,_,192-255
endif

" Hg
if has("win32")
  autocmd BufNewFile,BufRead hg-editor-*.txt setl fenc=cp1251 tw=79
endif

