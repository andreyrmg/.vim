if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " Delphi source file
  au BufNewFile,BufRead *.pas	 setf delphi
  " Delphi project file
  au BufNewFile,BufRead *.dpr	 setf delphi
  " Delphi form file
  au BufNewFile,BufRead *.dfm	 setf delphi
  au BufNewFile,BufRead *.xfm	 setf delphi
  " Delphi package file
  au BufNewFile,BufRead *.dpk	 setf delphi
  " Delphi .DOF file = INI file for MSDOS
  au BufNewFile,BufRead *.dof	 setf dosini
  au BufNewFile,BufRead *.dsk	 setf dosini
  " Delphi .BPG = Makefile
  au BufNewFile,BufRead *.bpg	 setf make|setlocal makeprg=make\ -f\ %
augroup END
