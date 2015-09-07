nnoremap <leader>h :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>h :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  silent execute "Ag! --" . &ft shellescape(@@)
  copen

  let @@ = saved_unnamed_register
endfunction
