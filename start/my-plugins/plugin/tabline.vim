try
  call projectroot#get('')
catch
  echomsg "dbakker/vim-projectroot needed!"
  finish
endtry

set showtabline=2

fu! s:do()
  if filereadable(nvim_buf_get_name(0))
    call tabline#do()
  endif
endfu

augroup setTabline
  autocmd!
  autocmd CursorHold * call s:do()
augroup END
