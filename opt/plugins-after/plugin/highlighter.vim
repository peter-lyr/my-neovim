let g:HiMapKeys = 0

let g:HiFollowWait = 0
let g:HiOneTimeWait = 0

nnoremap <leader>hn <cmd>:nohl<cr>

nnoremap <leader>hc <cmd>:Hi+<cr>
vnoremap <leader>hc <ESC><cmd>:Hi+x<cr>
nnoremap <leader>he <cmd>:Hi-<cr>
vnoremap <leader>he <ESC><cmd>:Hi-x<cr>

nnoremap <leader>hw <cmd>:Hi<cword><cr>
nnoremap <leader>hW <cmd>:Hi<cWORD><cr>

nnoremap <leader>hf <cmd>:Hi>><cr>

nnoremap <leader>hb <cmd>:Hi=<cr>
nnoremap <leader>ht <cmd>:Hi==<cr>

nnoremap <c-m> <cmd>:Hi}<cr>
nnoremap <c-n> <cmd>:Hi{<cr>

nnoremap <c-s-m> <cmd>:Hi><cr>
nnoremap <c-s-n> <cmd>:Hi<<cr>
