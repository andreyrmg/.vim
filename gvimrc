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
else
  let s:uname = system("uname -s")
  if s:uname == "Linux\n"
    set guifont=Ubuntu\ Mono\ 18
  elseif s:uname == "Darwin\n"
    set lines=34
    set columns=127
    set guifont=Monaco:h15
  endif
endif

set vb t_vb=

