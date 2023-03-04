hi default link DefxIconsMarkIcon Statement
hi default link DefxIconsCopyIcon WarningMsg
hi default link DefxIconsLinkIcon WarningMsg
hi default link DefxIconsMoveIcon ErrorMsg
hi default link DefxIconsDirectory Directory
hi default link DefxIconsParentDirectory Directory
hi default link DefxIconsSymlinkDirectory Directory
hi default link DefxIconsOpenedTreeIcon Directory
hi default link DefxIconsNestedTreeIcon Directory
hi default link DefxIconsClosedTreeIcon Directory

try
  call defx#custom#option('_', {
      \ 'winwidth': 65,
      \ 'split': 'vertical',
        \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
  call defx#custom#column('filename', {
      \ 'min_width': 36,
      \ 'max_width': 36,
      \ })
  call defx#custom#column('icon', {
      \ 'directory_icon': ' ',
      \ 'file_icon': '  ',
      \ 'opened_icon': ' ',
      \ 'root_icon': '',
      \ })
  call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '*',
      \ })
finally
endtry

let s:hack = 0
fu! defx2#defx(search, absfolder)
  if !s:hack
    let s:hack = 1
    GuiFont! Hack\ NFM:h9
  endif
  let absfolder = trim(a:absfolder, '\', 2)
  if len(a:search) && len(a:absfolder)
    exec printf("Defx -columns=indent:mark:icon:icons:filename:git:size:time "
          \ ."-sort=ctime -search=`%s` `%s`",
          \ string(a:search), string(a:absfolder))
  else
    Defx -columns=indent:mark:icon:icons:filename:git:size:time
  endif
  call defx1#defx_my_settings()
endfu

fu! s:get_cur_tab_buf_names()
  let bufnames = []
  for wn in range(1, winnr('$'))
    let bufname = nvim_buf_get_name(winbufnr(win_getid(wn)))
    if len(trim(bufname)) > 0
      let bufnames += [bufname]
    endif
  endfor
  return bufnames
endfu

fu! defx2#mydefxsearch()
  if &ft != 'defx'
    let closed = 1
    for bufName in s:get_cur_tab_buf_names()
      if match(bufName, '\[defx\]') > -1
        let closed = 0
        break
      endif
    endfor
    if closed
      call defx2#defx(expand('%:p'), expand('%:p:h'))
    else
      Defx
    endif
  else
    Defx
    wincmd p
  endif
  call defx1#defx_my_settings()
endfu

function! s:is_copened()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&filetype') == 'defx'
      return 1
    endif
  endfor
  return 0
endfunction

fu! defx2#close()
  if s:is_copened()
    Defx
  endif
endfu

fu! s:get_all_showed_buf_nrs()
  let showedBufNrs = []
  for tabIndex in range(1, tabpagenr('$'))
    let bufs = tabpagebuflist(tabIndex)
    for winIndex in range(len(bufs))
      let bufNr = bufs[winIndex]
      if nvim_buf_is_valid(bufNr)
        let showedBufNrs += [bufNr]
      endif
    endfor
  endfor
  return showedBufNrs
endfu

fu! defx2#bwipeDefxs()
  let allBufNrs = s:get_all_showed_buf_nrs()
  for i in getbufinfo()
    if match(nvim_buf_get_name(i['bufnr']), '\[defx\]') != -1
      exec 'bw! ' .i['bufnr']
    endif
  endfor
endfu

fu! defx2#go(path, path2)
  call defx2#bwipeDefxs()
  call defx2#defx(a:path, a:path2)
  call defx1#defx_my_settings()
endfu

fu! s:is_existed(abspath)
  let ret = 0
  python3 << EOF
import os, vim
abspath = vim.eval("a:abspath")
try:
    vim.command(f"""let ret = {
                1 if
                os.path.exists(abspath)
                else 0
    }""")
except:
    pass
EOF
  return ret
endfu

fu! s:parent_dir(abspath, level=1)
  if !s:is_existed(a:abspath)
    return 'cd'
  endif
  let level = a:level
  let abspath = substitute(a:abspath, '/', '\', 'g')
  let list = split(trim(abspath, '\', 2), '\')
  let length = len(list)
  if level > length - 1
    let level = length - 1
  endif
  return join(list[:length-level-1], '\')
endfu

fu! defx2#toggle()
  try
    NvimTreeClose
    call defx2#defx('', '')
  catch
  endtry
endfu

fu! defx2#cur()
  try
    NvimTreeClose
    call defx2#mydefxsearch()
  catch
  endtry
endfu

fu! defx2#cwd()
  try
    NvimTreeClose
    call defx2#go(getcwd(), s:parent_dir(getcwd()))
  catch
  endtry
endfu

set mousemodel=extend
autocmd WinEnter,BufEnter * call defx1#defx_my_settings()
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
