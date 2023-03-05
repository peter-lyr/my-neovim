let s:allow = 1

fu! fontsize#allow()
  let s:allow = 1
endfu

fu! s:echo()
  ec 'GuiFont! Hack\ NFM:h' .string(s:fontsize)
endfu

fu! fontsize#change(bigger)
  if !s:allow
    return
  endif
  let change = 0
  if a:bigger == 1
    if s:fontsize < 72
      let s:fontsize = s:fontsize + 1
      let change = 1
    endif
  elseif a:bigger == 2
    if s:fontsize < 72
      let s:fontsize = s:fontsize + 5
      let change = 1
    endif
  elseif a:bigger == -1
    if s:fontsize > 2
      let s:fontsize = s:fontsize - 1
      let change = 1
    endif
  elseif a:bigger == -2
    let s:fontsize = 2
    let change = 1
  else
    let s:fontsize = s:fontsizenormal
    let change = 1
  endif
  if change == 1
    exec 'GuiFont! Hack\ NFM:h' .string(s:fontsize)
    call timer_start(180, { -> <sid>echo() })
  endif
  let s:allow = 0
  call timer_start(100, { -> fontsize#allow() })
endfu

let s:fontsize = 9
let s:fontsizenormal = 9
