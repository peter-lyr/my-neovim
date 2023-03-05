inoremap <F1> <ESC><cmd>:call project#toggle()<CR>
vnoremap <F1> <ESC><cmd>:call project#toggle()<CR>
nnoremap <F1>      <cmd>:call project#toggle()<CR>

au BufEnter * call project#root()
