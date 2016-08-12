set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions+=c

set lines=45
set columns=135

if has("win32")
  set guifont=Consolas:h9:cDEFAULT
else
  let s:uname = system("uname -s")
  if s:uname == "Linux\n"
    set guifont=Ubuntu\ Mono\ 18
  elseif s:uname == "Darwin\n"
    set lines=46
    set columns=182
    set guifont=Monaco:h18
  endif
endif

set vb t_vb=

