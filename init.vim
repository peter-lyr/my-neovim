lua << eof
vim.g.mapleader = " "
eof

packadd init
packadd plugins

let s:load_immediately_filetpyes = [
      \ 'c',
      \ ]

fu! MyBufEnter(force)
  if a:force == 2
    echomsg "5 secs..."
  endif
  if a:force || len(expand('%:p')) && !exists("s:after_loaded_group") &&
        \ index(s:load_immediately_filetpyes, &ft) != -1
    let s:after_loaded_group = 1
    packadd plugins-after
    map <silent><f5> <cmd>:e!<cr>
    if exists('#after_loaded_group')
      autocmd! after_loaded_group
    endif
  endif
endfu

augroup after_loaded_group
  au!
  map <f5> <cmd>:call MyBufEnter(1)<cr>
  au bufenter * call MyBufEnter(0)
  au focuslost * call MyBufEnter(1)
augroup end

call timer_start(5000, { -> MyBufEnter(2) })
