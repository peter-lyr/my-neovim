nnoremap <leader>gi <cmd>:call diffview#FileHistory()<CR>
nnoremap <leader>go <cmd>:call diffview#OpenFocusFiles()<CR>
nnoremap <leader>gq <cmd>:call diffview#Close()<CR>
nnoremap <leader>ge <cmd>:DiffviewRefresh<CR>
nnoremap <leader>gl <cmd>:DiffviewToggleFiles<CR>

nnoremap <leader>gt <cmd>:call diffview#counttoggle()<CR>

" git difftool -y --tool=bc4 ac9e370..b473659 msgpackc.dll
