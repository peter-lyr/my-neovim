fu! tabline#e(text, length=10000, dir=1) " dir=1正向，dir=0反向
  let res = ''
  let d = str2list(a:text)
  if a:dir == 0
    call reverse(d)
  endif
  let l = len(d)
  let cnt = 0
  for i in range(l)
    let ch = nr2char(d[i])
    let cnt += strwidth(ch)
    if cnt > a:length
      break
    endif
    let res .= ch
  endfor
  if a:dir == 0
    return list2str(reverse(str2list(res)))
  endif
  return res
endfu

let s:len = 20
let s:len2 = s:len / 2 - 1

fu tabline#getFileName(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let res = getcwd(winnr, a:n)
  let bufpath = nvim_buf_get_name(buflist[winnr-1])
  if len(bufpath) == 0
    return printf("%d)+", a:n)
  endif
  if bufpath[:3] == 'term'
    let term = split(bufpath, '//')[-1]
    if len(term) > s:len
      return printf("%d)%s", a:n, tabline#e(term, s:len2 + 4, 1) .'..' .tabline#e(term, s:len2 - 4, 1))
    endif
    return printf("%d)%s", a:n, term)
  endif
  let projectroot = projectroot#get(bufpath)
  let projectroot = substitute(projectroot, '\', '/', 'g')
  let projectroot = trim(projectroot)
  if len(projectroot) == 0
    let fname = nvim_buf_get_name(buflist[winnr-1])
    let fname = substitute(fname, '\', '/', 'g')
    let fname = split(fname, '/')
    if len(fname) > 0
      let fname = fname[-1]
    else
      let fname = 'no name'
    endif
    if len(fname) > s:len
      return printf("%d)[%s]", a:n, tabline#e(fname, s:len2 + 4, 1) .'..' .tabline#e(fname, s:len2 - 4, 0))
    else
      return printf("%d)[%s]", a:n, fname)
    endif
  endif
  let proj = split(projectroot, '/')
  if len(proj) > 0
    let proj = proj[-1]
  else
    let proj = '[no proj]'
  endif
  if len(proj) > s:len
    return printf("%d)%s", a:n, tabline#e(proj, s:len2 + 4, 1) .'..' .tabline#e(proj, s:len2 - 4, 0))
  else
    return printf("%d)%s", a:n, proj)
  endif
endfu

fu tabline#setTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= '%' . (i + 1) . 'T'
    let s .= ' %{tabline#getFileName(' . (i + 1) . ')} '
  endfor
  let s .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let s .= "%=%#TabLine#[%{tabpagenr('$')}]"
  endif
  return s
endfu

fu! tabline#do()
  autocmd! setTabline
  set tabline=%!tabline#setTabLine()
endfu

hi TabLine      gui=NONE  guifg=#777777 guibg=NONE
hi TabLineFill  gui=NONE  guifg=NONE    guibg=NONE
hi TabLineSel   gui=bold  guifg=#27d276 guibg=NONE
