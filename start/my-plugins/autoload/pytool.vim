fu! s:temp()
  return $HOMEDRIVE .$HOMEPATH .'\temps'
endfu

let s:foldername = 'pytool'

fu! s:pipe()
  let folder = s:temp() .'\' .s:foldername
  if !isdirectory(folder)
    call system(printf('mkdir %s', folder))
  endif
  return printf('%s\pipe.txt', folder)
endfu

fu! pytool#showeachbitcword()
  call pytool#showeachbitdo(s:cword)
endfu

fu! pytool#showeachbitdo(text='')
  let text = a:text
  if len(text) == 0
    let text = input('要知道哪个整型数字的每个二进制位的情况？: ')
  endif
  let s:bufAbspath = expand('%:p')
  let s:lineNr = line('.')
  call writefile([''], s:pipe(), 'b')
  call ipython#runHide('%run '
        \ .mycommon#fileAndParams(mycommon#GetUsedFile('python\showEachBit.py'),
        \ [
        \   text,
        \   s:pipe(),
        \ ]))
  let s:waitCalResTimer = timer_start(10, { -> <sid>pasteCalResToBuf(
        \ s:bufAbspath, s:lineNr, s:pipe()) }, {'repeat' : -1})
endfu

fu! s:pasteCalResToBuf(bufAbspath, lineNr, pipeAbspath)
  let content = readfile(a:pipeAbspath)
  if len(content) > 0 && len(content[0]) > 0
    call writefile([''], a:pipeAbspath, 'b')
    call timer_stop(s:waitCalResTimer)
    if !terminal#tryGoTo(a:bufAbspath)
      new
      exec 'e ' .a:bufAbspath
    endif
    if &modifiable
      call append(a:lineNr, content)
      exec 'norm ' .a:lineNr .'gg'
      norm 4j0zz
    endif
  endif
endfu

fu! pytool#do(key)
  exec printf("call %s()", s:dict[a:key])
endfu

fu! pytool#sel()
  let s:cword = expand('<cword>')
  call telescope_extension#sel('py tool', keys(s:dict), 'pytool#do')
endfu

let s:dict = {
      \ 'Show each bits (input)': 'pytool#showeachbitdo',
      \ 'Show each bits (cword)': 'pytool#showeachbitcword',
      \ }
