if has("osx")
  let s:clang_format_py = "/usr/local/opt/clang-format/share/clang/clang-format.py"
else
  let s:clang_format_py = "clang-format.py"
endif

function! s:FormatFile()
  let l:lines = "all"
  execute 'py3f' s:clang_format_py
endfunction

if filereadable(s:clang_format_py)
  autocmd BufWritePre <buffer> call <SID>FormatFile()
endif
