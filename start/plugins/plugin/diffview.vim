nnoremap <leader>gi <cmd>:call diffview#FileHistory()<cr>
nnoremap <leader>go <cmd>:call diffview#OpenFocusFiles()<cr>
nnoremap <leader>gq <cmd>:call diffview#Close()<cr>
nnoremap <leader>ge <cmd>:DiffviewRefresh<cr>
nnoremap <leader>gl <cmd>:DiffviewToggleFiles<cr>

nnoremap <leader>gt <cmd>:call diffview#counttoggle()<cr>

" git difftool -y --tool=bc4 ac9e370..b473659 msgpackc.dll
