set guioptions-=T
set guioptions-=m
set guioptions+=c

set lines=45
set columns=135

if has("win32")
  set guifont=Consolas:h9:cDEFAULT
else
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set lines=55
    set columns=156
    set guifont=Menlo:h14
  endif
endif

set vb t_vb=

