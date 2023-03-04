fu! Tab_indent()
  if &ft == 'c'
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
  else
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
  endif
endfu

au BufEnter * call Tab_indent()
