set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions+=c

if has("win32")
  set guifont=Liberation\ Mono:h12:cDEFAULT
  if has("directx")
    set renderoptions=type:directx,level:1.0,geom:1,renmode:3,taamode:1
  endif
elseif has("osx")
  set guifont=Menlo:h14
elseif has("unix")
  set guifont=Ubuntu\ Mono\ 12
endif

set vb t_vb=

