scriptencoding utf-8
set nocompatible

if exists("did_load_filetypes")
  filetype off
  filetype plugin indent off
endif

" plugins {{{
" vim-plug initialization {{{
if has("win32")
  let s:dotvim = '~/vimfiles'
else
  let s:dotvim = '~/.vim'
endif
let s:plug_file = s:dotvim . '/autoload/plug.vim'
if !filereadable(expand(s:plug_file))
  execute 'silent !curl -fLo' s:plug_file '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

call plug#begin(s:dotvim . '/plugged')

Plug 'altercation/vim-colors-solarized'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'wincent/command-t', { 'do': 'cd ./ruby/command-t && ruby extconf.rb && make' }

Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'vim-scripts/paredit.vim', { 'for': 'clojure' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive'
      \ }
      \ }
function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'python'], 'do': './install.sh --clang-completer --system-libclang' }
let g:ycm_min_num_of_chars_for_completion = 999
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_conf.py'

Plug 'zah/nim.vim', { 'for': 'nim' }

call plug#end()
" }}}

filetype plugin indent on
syntax on

set exrc

" tabs and spaces
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set shiftround

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

" set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

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

"set clipboard+=unnamed

set autoread
set autowrite

set nowrap

set list listchars=tab:→\ ,trail:·

" mappings {{{
let mapleader=","

nnoremap <silent> <leader>wa :1,9000bwipeout<cr>

nnoremap <silent> <leader>cd :lcd %:h<cr>
nnoremap <silent> <leader>md :!mkdir -p %:p:h<cr>

nnoremap <silent> <leader>n :nohlsearch<cr>
nnoremap <silent> <cr>      :nohlsearch<cr><cr>

nnoremap <silent> <leader>ww :set invwrap<cr>:set wrap?<cr>

nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

nnoremap <silent> <leader>x :w<cr>:!chmod 755 %<cr>:e<cr>

nnoremap <leader>sp :rightbelow split<space>
nnoremap <leader>vs :rightbelow vsplit<space>

nnoremap <M-Up> :resize -5<cr>
nnoremap <M-Down> :resize +5<cr>
nnoremap <M-Left> :vertical resize -5<cr>
nnoremap <M-Right> :vertical resize +5<cr>

nnoremap <leader>l :setl list! list?<cr>

" just save the current buffer
nnoremap <f2> :w<cr>
" save the current buffer and continue editing at the same position
inoremap <f2> <esc>:w<cr>
" }}}

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
set background=dark
colorscheme solarized

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
    autocmd FileType vim        setl foldmethod=marker
    autocmd FileType xml        setl ts=4 sts=4 sw=4 et
    autocmd FileType java       setl ts=4 sts=4 sw=4 et
    autocmd FileType javascript setl ts=4 sts=4 sw=4 et
    autocmd FileType groovy     setl ts=4 sts=4 sw=4 et
    autocmd FileType go         setl ts=4 sts=4 sw=4 noet |
          \ nnoremap <buffer> <leader>r <Plug>(go-run) |
          \ nnoremap <buffer> <leader>i <Plug>(go-install)
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
