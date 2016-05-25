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
Plug 'altercation/vim-colors-solarized'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'wincent/command-t', {
      \ 'do': 'cd ./ruby/command-t && ruby extconf.rb && make'
      \ }
let g:CommandTFileScanner = 'git'
let g:CommandTMatchWindowReverse = 0
let g:CommandTAcceptSelectionSplitCommand = 'rightbelow sp'
let g:CommandTAcceptSelectionVSplitCommand = 'rightbelow vs'

Plug 'rking/ag.vim'

Plug 'hynek/vim-python-pep8-indent', {
      \ 'for': 'python'
      \ }

Plug 'rust-lang/rust.vim', {
      \ 'for': 'rust'
      \ }

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
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
set number
set nowrap
set noshowmode
set sidescroll=1
set timeoutlen=1000
set ttimeoutlen=0
set virtualedit=onemore
set wildignore+=**/*.o
set wildignore+=**/*.pyc
set wildignore+=**/*.class
set wildignore+=**/build/*
set wildignore+=**/target/*
set wildmenu
set wildmode=longest,full

" color scheme {{{
set t_Co=256
set t_ut=
set background=dark
colorscheme hybrid
let g:solarized_visibility="low"
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
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" }}}
" mappings {{{
let mapleader=","

nnoremap <silent> <leader>wa :1,9000bwipeout<cr>

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
inoremap <f2> <esc>:w<cr>

" disable Ex mode
nnoremap Q <nop>

" quick quit
nnoremap <leader>q ZQ

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
    autocmd FileType vim        setl foldmethod=marker
    autocmd FileType xml        setl sts=4 sw=4 et
    autocmd FileType java       setl sts=4 sw=4 et
    autocmd FileType javascript setl sts=4 sw=4 et
    autocmd FileType groovy     setl sts=4 sw=4 et
    autocmd FileType go         setl sts=4 sw=4 noet ts=4 |
          \ nmap <buffer> <leader>gr <Plug>(go-run) |
          \ nmap <buffer> <leader>gi <Plug>(go-install)
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
