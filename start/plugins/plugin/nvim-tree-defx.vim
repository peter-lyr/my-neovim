set mousemodel=extend
autocmd WinEnter,BufEnter * call defx1#defx_my_settings()
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
nnoremap <leader><leader>; <cmd>:call defx2#toggle()<cr>
nnoremap <leader><leader>' <cmd>:call defx2#cur()<cr>
nnoremap <leader><leader>\ <cmd>:call defx2#cwd()<cr>

nnoremap <leader>; <cmd>:call nvimtree#toggle()<cr>
nnoremap <leader>' <cmd>:call nvimtree#cur()<cr>
nnoremap <leader>" <cmd>:call nvimtree#find()<cr>
nnoremap <leader>\ <cmd>:call nvimtree#cwd()<cr>
