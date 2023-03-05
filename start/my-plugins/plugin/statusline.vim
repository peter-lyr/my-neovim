call timer_start(10, 'statusline#timerUpdate',{'repeat':-1})
autocmd WinEnter,BufEnter,VimResized * call statusline#watch()
autocmd ColorScheme * call statusline#color()
