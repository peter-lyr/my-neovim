let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = "left"
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

let g:NERDAltDelims_c = 1

nnoremap <silent> <leader>cp vip:call nerdcommenter#Comment('x', 'toggle')<cr>
nnoremap <silent> <leader>c} V}k:call nerdcommenter#Comment('x', 'toggle')<cr>
nnoremap <silent> <leader>c{ V{j:call nerdcommenter#Comment('x', 'toggle')<cr>
nnoremap <silent> <leader>cG  VG:call nerdcommenter#Comment('x', 'toggle')<cr>
