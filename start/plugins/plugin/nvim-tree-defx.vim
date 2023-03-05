try
  call timer_stop(g:nvimtreetimer)
catch
endtry
let g:nvimtreetimer = timer_start(10, { -> nvimtree#do() }, {'repeat': -1})

nnoremap <leader><leader>; <cmd>:call defx2#toggle()<cr>
nnoremap <leader><leader>' <cmd>:call defx2#cur()<cr>
nnoremap <leader><leader>\ <cmd>:call defx2#cwd()<cr>

nnoremap <leader>; <cmd>:call nvimtree#toggle()<cr>
nnoremap <leader>' <cmd>:call nvimtree#cur()<cr>
nnoremap <leader>" <cmd>:call nvimtree#find()<cr>
nnoremap <leader>\ <cmd>:call nvimtree#cwd()<cr>
