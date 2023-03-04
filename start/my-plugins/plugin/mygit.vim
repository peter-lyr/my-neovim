nnoremap <leader>g1 <cmd>:call mygit#addCommitPush()<CR>
nnoremap <leader>g2 <cmd>:call mygit#commitPush()<CR>
nnoremap <leader>g3 <cmd>:call mygit#justPush()<CR>

nnoremap <leader>g4 <cmd>:call mygit#addCommit()<CR>
nnoremap <leader>g5 <cmd>:call mygit#justCommit()<CR>

nnoremap <leader>gG <cmd>:Git log --all --abbrev-commit --pretty=reference --date=human<CR>
nnoremap <leader>gv <cmd>:call mygit#diff()<CR>

nnoremap <leader>gI <cmd>:call mygit#init()<CR>

nnoremap <leader>g<f1> <cmd>:call mygit#graph()<CR>
