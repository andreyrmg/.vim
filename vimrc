scriptencoding utf-8
set nocompatible

if exists("did_load_filetypes")
  filetype off
  filetype plugin indent off
endif

if has("win32")
  let s:dotvim = '~/vimfiles'
else
  let s:dotvim = '~/.vim'
endif
let s:bundle = s:dotvim . '/bundle'
let s:vundle = s:bundle . '/Vundle.vim'

if !isdirectory(expand(s:vundle))
  exe '!git clone https://github.com/gmarik/Vundle.vim.git ' . s:vundle
endif

exe 'set rtp+=' . s:vundle
call vundle#begin(s:bundle)

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'

Plugin 'wincent/command-t'
let g:CommandTFileScanner = 'find'

Plugin 'hynek/vim-python-pep8-indent'

Plugin 'vim-ruby/vim-ruby'

Plugin 'fatih/vim-go'

Plugin 'derekwyatt/vim-scala'

Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'

Plugin 'vim-scripts/paredit.vim'

Plugin 'rust-lang/rust.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive'
      \ }
      \ }
function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on
syntax on

set exrc

" tabs and spaces
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = shiftwidth = softtabstop = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop=' . &l:ts
    echon ' shiftwidth=' . &l:sw
    echon ' softtabstop=' . &l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

set wrapscan

set ch=1

set novisualbell
set t_vb=

set backspace=indent,eol,start

set hidden

set cpoptions=Bces$

set stl=%f\ %M%R\ %l:%v/%L\ %y\ [0x%B]

set laststatus=2

set showcmd

set showmode

syntax on

set mousehide

set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

set history=100

set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set virtualedit=all

set wildmenu

set wildignore+=**/*.pyc
set wildignore+=**/*.class

" search options
set gdefault
set hlsearch
set ignorecase smartcase
set incsearch
nnoremap <silent> <cr> :nohlsearch<cr><cr>

"set clipboard+=unnamed

set autoread
set autowrite

set nowrap

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

nmap <c-j> :bprev<cr>
nmap <c-k> :bnext<cr>

nnoremap <M-Up> :resize -5<cr>
nnoremap <M-Down> :resize +5<cr>
nnoremap <M-Left> :vertical resize -5<cr>
nnoremap <M-Right> :vertical resize +5<cr>

nmap <leader>l :set list!<cr>
set list!
set listchars=tab:→\ ,trail:·

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>

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
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd FileType python setl ts=4 sts=4 sw=4 et
  autocmd FileType xml setl ts=4 sts=4 sw=4 et
  autocmd FileType java setl ts=4 sts=4 sw=4 et
  autocmd FileType javascript setl ts=4 sts=4 sw=4 et
  autocmd FileType groovy setl ts=4 sts=4 sw=4 et

  au FileType go setl ts=4 sts=4 sw=4 noet
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>i <Plug>(go-install)
endif

" Hg
if has("win32")
  autocmd BufNewFile,BufRead hg-editor-*.txt setl fenc=cp1251 tw=79
endif

" Fast save
nmap <f2> :w<cr>
imap <f2> <esc>:w<cr>
vmap <f2> <esc>:w<cr>

