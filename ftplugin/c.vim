setlocal commentstring=//%s

function! s:FormatFile()
  let l:lines = "all"
  execute 'py3f' s:clang_format_py
endfunction

let s:clang_format_py_paths = [
      \ "/usr/lib/llvm/9/share/clang/clang-format.py",
      \ "/usr/lib/llvm/8/share/clang/clang-format.py",
      \ "/usr/local/opt/clang-format/share/clang/clang-format.py",
      \ "/usr/share/clang/clang-format.py",
      \ ]
for path in s:clang_format_py_paths
  if filereadable(path)
    let s:clang_format_py = path
  endif
endfor

if filereadable(s:clang_format_py)
  autocmd BufWritePre <buffer> call <SID>FormatFile()

  execute "nnoremap <buffer> <c-i> :py3f " . s:clang_format_py . "<cr>"
endif

inoremap <buffer> {<cr> {<cr>}<c-o>O
