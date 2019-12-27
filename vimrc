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

Plug 'andreyrmg/vim-hybrid'
Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
Plug 'cocopon/lightline-hybrid.vim'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive'
      \ }
      \ }
function! LightlineFugitive()
  return exists('*fugitive#statusline') ? fugitive#statusline() : ''
endfunction

Plug 'dag/vim-fish'

Plug 'rust-lang/rust.vim', {
      \ 'for': 'rust'
      \ }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': has('win32') ? 'powershell -executionpolicy bypass -File install.ps1' : 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', '', 'rls'],
    \ }
nnoremap <f5> :call LanguageClient_contextMenu()<cr>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
nnoremap <silent> <s-f6> :call LanguageClient#textDocument_rename()<cr>

Plug 'qpkorr/vim-bufkill'
let g:BufKillOverrideCtrlCaret = 1

Plug 'airblade/vim-rooter'
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1

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
set formatoptions+=jnro
set guioptions+=f
set hidden
set laststatus=2
set list
set listchars=tab:→\ ,trail:·
set modeline
set nowrap
set noshowmode
set nostartofline
set number
set path+=**
set relativenumber
set scrolloff=3
set sidescroll=1
set signcolumn=yes
set splitright
set timeoutlen=1000
set ttimeoutlen=0
set virtualedit=onemore
set visualbell t_vb=
set wildignore+=**/*.o
set wildignore+=**/*.pyc
set wildignore+=**/*.class
set wildignore+=**/build/*
set wildignore+=**/target/*
set wildmenu
set wildmode=full,full
set winwidth=80

let g:pascal_fpc = 1
let g:pascal_delphi = 1

let g:rustfmt_autosave = 1

let g:hs_highlight_delimiters = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_types = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_debug = 1
let g:hs_allow_hash_operator = 1

" color scheme {{{
set t_Co=256
set t_ut=
set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
else
  colorscheme base16-gruvbox-dark-hard
endif
" }}}
" tabs and spaces {{{
set shiftwidth=2
set softtabstop=-1
set expandtab
set autoindent
set shiftround
" }}}
" search options {{{
set gdefault
set incsearch
set ignorecase
set smartcase
" }}}
" backups {{{
set nobackup
set nowritebackup
set noswapfile
" }}}
" undo {{{
let s:undodir = expand(s:dotvim . "/.udir")
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 0700)
endif
execute "set undodir=" . s:undodir
set undofile
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

nnoremap <silent> <leader>n :nohlsearch<cr>
nnoremap <silent> <cr>      :nohlsearch<cr><cr>

nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

if has('unix')
  nnoremap <silent> <leader>md :!mkdir -p %:p:h<cr>
  nnoremap <silent> <leader>x :!chmod u+x %<cr>:e<cr>
endif

" just save the current buffer
nnoremap <f2> :w<cr>
nnoremap <leader>w :w<cr>
inoremap <f2> <c-o>:w<cr>

" disable Ex mode
nnoremap Q @q
vnoremap Q :norm @q<cr>

" quick repeat last shell command
nnoremap <leader>1 :!!<cr>

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

inoremap <c-j> <esc>
vnoremap <c-j> <esc>

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

" exit from terminal
tnoremap <expr> <esc> &filetype == "fzf" ? "<esc>" : "<c-\><c-n>"
tnoremap <expr> <c-j> &filetype == "fzf" ? "<c-j>" : "<c-\><c-n>"

" quick make
nnoremap M :silent make\|redraw!\|cl<cr>

" fzf
command! -bang -nargs=? -complete=dir
  \ Files call fzf#vim#files(<q-args>, {'source': 'fd'}, <bang>0)
nnoremap <c-n> :Files<cr>
nnoremap <c-e> :Buffers<cr>
" }}}

" autocommands {{{
if has("autocmd")
  augroup vimrc_general
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END

  augroup vimrc_filetypes
    autocmd!
    autocmd FileType java,xml setlocal shiftwidth=4
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
