fu! keymaps#f2()
  if &ft == 'c' || &ft == 'cpp' || &ft == 'h'
    try
      ClangdSwitchSourceHeader
    catch
      echomsg "Lsp no start."
    endtry
  elseif &ft == 'markdown'
    MarkdownPreviewToggle
  elseif &ft == 'vim'
    let f = nvim_buf_get_name(0)
    let g = substitute(f, '\', '/', 'g')
    let h = split(g, '/')
    if h[-2] == 'autoload'
      let h[-2] = 'plugin'
    else
      let h[-2] = 'autoload'
    endif
    let j = join(h, '/')
    let i = printf('e %s', j)
    if filereadable(j)
      exec i
    endif
  endif
endfu

fu! keymaps#space_cr()
  if !exists('g:lasttab')
    return
  endif
  exe "tabn ".g:lasttab
endfu

let g:word = ''
let g:bigword = ''

au TabLeave * let g:lasttab = tabpagenr()
au BufLeave * let g:word = expand('<cword>')

nnoremap <F2> <cmd>:silent call keymap#f2()<cr>
nnoremap <leader><cr> <cmd>:call keymap#space_cr()<cr>
