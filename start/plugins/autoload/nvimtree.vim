let s:fname = ''
let s:projname = ''

let g:nvimtree_autoopen = 1

fu! nvimtree#do()
  let curfname = substitute(nvim_buf_get_name(0), '/', '\', 'g')
  if g:nvimtree_autoopen && len(curfname) > 0 && filereadable(curfname) && s:fname != curfname && &bin == 0
    let s:fname = curfname
    let curprojname = substitute(projectroot#get(curfname), '/', '\', 'g')
    if isdirectory(curprojname) && s:projname != curprojname
      let s:projname = curprojname
      NvimTreeClose
      exec 'NvimTreeOpen ' .curprojname
      wincmd p
    endif
    if exists("g:mynvimtreeflag") && g:mynvimtreeflag == 1
      try
        call defxNvim2#Close()
        AerialCloseAll
        MindClose
      catch
      endtry
      NvimTreeFindFile!
      let g:mynvimtreeflag = 0
    else
      try
        call defxNvim2#Close()
        AerialCloseAll
        MindClose
      catch
      endtry
      NvimTreeFindFile
    endif
    let line = getline('.')
    if len(line) > 30
      exec "norm 0^zLv^hhhh\<esc>\<F3>"
    endif
    wincmd p
  endif
endfu

fu! nvimtree#toggle()
  try
    call defx2#close()
    NvimTreeToggle
  catch
  endtry
endfu

fu! nvimtree#cur()
  try
    call defx2#close()
    NvimTreeFindFile
  catch
  endtry
endfu

fu! nvimtree#cwd()
  try
    call defx2#close()
    exec 'NvimTreeOpen ' .getcwd()
  catch
  endtry
endfu

fu! nvimtree#find()
  try
    NvimTreeFindFile!
  catch
  endtry
endfu
