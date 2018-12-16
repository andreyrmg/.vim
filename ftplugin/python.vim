setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

function! AnalizeTracebackFromClipboard()
  let l:traces = []
  for item in split(@+, '\n')
    let l:match = matchlist(item, '\v^\s+File "(.+)", line (\d+), in (\w+)$')
    if len(l:match) > 0
      call add(l:traces, {"filename": l:match[1], "lnum": l:match[2], "text": l:match[3]})
    endif
  endfor
  if len(l:traces) > 0
    call setloclist(0, l:traces)
    lopen
  endif
endfunction

nnoremap <leader>as :call AnalizeTracebackFromClipboard()
