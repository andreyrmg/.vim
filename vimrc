scriptencoding utf-8

" plugins {{{
" vim-plug initialization {{{
if has("win32")
  let s:dotvim = '~/vimfiles'
else
  let s:dotvim = '~/.vim'
endif
let s:plug_file = s:dotvim . '/autoload/plug.vim'
if !filereadable(expand(s:plug_file))
  silent execute '!curl -fLo' s:plug_file '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

call plug#begin(s:dotvim . '/plugged')

Plug 'w0ng/vim-hybrid'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'itchyny/lightline.vim'
Plug 'cocopon/lightline-hybrid.vim'
let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive'
      \ }
      \ }
function! LightlineFugitive()
  return exists('*fugitive#statusline') ? fugitive#statusline() : ''
endfunction

let s:custom_plugins_file = s:dotvim . '/' . 'plugins.vim'
if filereadable(expand(s:custom_plugins_file))
  execute 'source' s:custom_plugins_file
endif

call plug#end()
" }}}

filetype on
filetype plugin indent on
syntax on

set autoread
set autowrite
set backspace=indent,eol,start
set colorcolumn=+1
set cpoptions+=$
set encoding=utf-8
set exrc
set hidden
set laststatus=2
set list
set listchars=tab:→\ ,trail:·
set modeline
set nowrap
set noshowmode
set path+=**
set scrolloff=3
set sidescroll=1
set splitright
set timeoutlen=1000
set ttimeoutlen=0
set virtualedit=onemore
set wildignore+=**/*.o
set wildignore+=**/*.pyc
set wildignore+=**/*.class
set wildignore+=**/build/*
set wildignore+=**/target/*
set wildmenu
set wildmode=list:longest
set winwidth=80

let g:pascal_fpc = 1
let g:pascal_delphi = 1

let g:rustfmt_autosave = 1

" color scheme {{{
set t_Co=256
set t_ut=
set background=dark
colorscheme hybrid
" }}}
" tabs and spaces {{{
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set shiftround
" }}}
" search options {{{
set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}
" backups {{{
set nobackup
set nowritebackup
set noswapfile
" }}}
" input method {{{
if has('osx')
  set keymap=russian-jcukenmac
else
  set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=-1
" }}}
" mappings {{{
let mapleader=","
let maplocalleader=","

nnoremap <silent> <leader>cd :lcd %:h<cr>
nnoremap <silent> <leader>md :!mkdir -p %:p:h<cr>

nnoremap <silent> <leader>n :nohlsearch<cr>
nnoremap <silent> <cr>      :nohlsearch<cr><cr>

nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

nnoremap <silent> <leader>x :w<cr>:!chmod 755 %<cr>:e<cr>

nnoremap <leader>sp :rightbelow split<space>
nnoremap <leader>vs :rightbelow vsplit<space>

" just save the current buffer
nnoremap <f2> :w<cr>
nnoremap <leader>w :w<cr>
inoremap <f2> <esc>:w<cr>

" disable Ex mode
nnoremap Q gq

" quick quit
nnoremap <leader>q ZQ
" quick command mode
nnoremap ; :

function! s:CompleteOrInsertTab()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> <SID>CompleteOrInsertTab()
inoremap <s-tab> <c-n>

" copy/paste to/from X clipboard
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" go to another window
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <d-9> :Gstatus<cr>
nnoremap <m-9> :Gstatus<cr>
" }}}

" autocommands {{{
if has("autocmd")
  augroup vimrc_general
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   execute "normal! g`\"" |
          \ endif
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END

  augroup vimrc_filetypes
    autocmd!
    autocmd FileType xml        setl sts=4 sw=4 et
    autocmd FileType java       setl sts=4 sw=4 et
    autocmd FileType javascript setl sts=4 sw=4 et
    autocmd FileType groovy     setl sts=4 sw=4 et
  augroup END

  " Hg
  if has("win32")
    augroup win32
      autocmd!
      autocmd BufNewFile,BufRead hg-editor-*.txt setl fenc=cp1251 tw=78
    augroup END
  endif
endif
" }}}
" Windows {{{
if has("win32")
  set backupcopy=yes
  set fencs+=cp1251
  language ctype Russian_Russia.1251
endif
" }}}
