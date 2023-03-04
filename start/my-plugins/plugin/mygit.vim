nnoremap <leader>g1 <cmd>:call mygit#addCommitPush()<cr>
nnoremap <leader>g2 <cmd>:call mygit#commitPush()<cr>
nnoremap <leader>g3 <cmd>:call mygit#justPush()<cr>

nnoremap <leader>g4 <cmd>:call mygit#addCommit()<cr>
nnoremap <leader>g5 <cmd>:call mygit#justCommit()<cr>

nnoremap <leader>gG <cmd>:Git log --all --abbrev-commit --pretty=reference --date=human<cr>
nnoremap <leader>gv <cmd>:call mygit#diff()<cr>

nnoremap <leader>gI <cmd>:call mygit#init()<cr>

nnoremap <leader>g<f1> <cmd>:call mygit#graph()<cr>
