fu! binxxd#isbin(fname='')
  let fname = a:fname
  if len(fname) == 0
    let fname = nvim_buf_get_name(0)
  endif
  let res = split(trim(execute(printf("!file -bi \"%s\"", fname)), '\n'))
  if len(res) > 1 && match(res[-1], 'binary') != -1 && match(res[-2], 'empty') == -1
    return 1
  endif
  return 0
endfu

let s:d = {
      \ 'h': 'topleft vnew',
      \ 'j': 'new',
      \ 'k': 'topleft new',
      \ 'l': 'vnew',
      \ 'o': '',
      \ 't': 'tabnew',
      \ }

fu! binxxd#readPre()
  let &bin = 0
  let flag = 0
  let s:open = ''
  let fname = nvim_buf_get_name(0)
  if filereadable(fname) && binxxd#isbin(fname)
    if index(['bin', 'a'], tolower(split(fname, '\.')[-1])) != -1
      let flag = 1
    else
      let res = trim(input(printf('[%s] as bin? [h/j/k/l/o/t/n]: ', fname), 't'))
      if index(['h', 'j', 'k', 'l', 'o', 't'], res) != -1
        let s:open = s:d[res]
        let flag = 1
      elseif res == ""
        let bufnr = bufnr()
        exec "norm \<c-o>"
        exec printf("%dbw!", bufnr)
      endif
    endif
  endif
  if flag == 1
    let fsize = getfsize(fname)
    if fsize >= 50 * 1024 * 1024
      let bufnr = bufnr()
      exec "norm \<c-o>"
      exec printf("%dbw!", bufnr)
      echomsg printf("bin too big! [%dMB>50MB] [%s]", fsize / 1024 / 1024, fname)
      return
    endif
    let &bin = 1
  endif
endfu

fu! binxxd#readPost()
  if &bin == 1
    let fname = nvim_buf_get_name(0)
    exec "norm \<c-o>"
    exec s:open
    exec printf("e %s", fname)
    clearjumps
    let wait = 0
    if getfsize(fname) >= 5 * 1024 * 1024
      let wait = 1
    endif
    if wait
      echomsg printf('%s "trying... [%s]', s:cmd, fname)
    endif
    exec printf("silent %s", s:cmd)
    if wait
      echomsg printf('%s "done!', s:cmd)
    endif
    tabmove $
    setlocal binary
    setlocal ft=xxd
    setlocal nomodifiable
    map <buffer> <F5> <Nop>
    cmap <buffer> e norm l<CR>
  endif
endfu

let s:cmd = '%!xxd -u -g4 -c32'
