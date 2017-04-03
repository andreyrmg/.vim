set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions+=c

set lines=45
set columns=135

if has("win32")
  set guifont=Consolas:h10:cDEFAULT
  if has("directx")
    set renderoptions=type:directx
  endif
elseif has("unix")
  set guifont=Ubuntu\ Mono\ 12
elseif has("osx")
  set guifont=Menlo:h14
endif

set vb t_vb=

