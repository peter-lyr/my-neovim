fu! s:test(context) abort
endfu

"fu! s:deleteToRecycleBin(context) abort
"  let filesandfolders = join(a:context.targets, '" "')
"  if Sure(printf('要回收到垃圾桶吗？"%s": ', filesandfolders), 'y')
"    call MyAsyncRun([printf('%s "%s"',
"          \ PathJoin([g:nvim_root, 'exe/beused/2_recycle-bin.exe']),
"          \ filesandfolders)], 2)
"  endif
"endfu
"
"fu! s:systemCopy(context) abort
"  let filesandfolders = join(a:context.targets, '" "')
"  call MyAsyncRun([printf('%s "%s"',
"        \ PathJoin([g:nvim_root, 'exe/beused/1_file2clip.exe']),
"        \ filesandfolders)], 2)
"endfu
"
"fu! s:systemPaste(context) abort
"  let current_path = a:context.targets[0]
"  if !isdirectory(current_path)
"    let current_path = a:context.cwd
"  endif
"  call MyAsyncRun([printf('%s && powershell.exe -f "%s"',
"        \ SystemCd(current_path),
"        \ PathJoin([g:nvim_root, 'ps1/beused/1_paste.ps1'])
"        \ )], 2)
"endfu

fu! s:system_cd(absfolder)
  if !isdirectory(a:absfolder)
    return ''
  endif
  return a:absfolder[0] .': && cd ' .a:absfolder
endfu

fu! s:systemstart(context) abort
  let current_path = a:context.targets[0]
  if !isdirectory(current_path)
    let current_path = a:context.cwd
  endif
  silent exec printf('!%s && start .', s:system_cd(current_path))
endfu

fu! s:getlongestfnamelen(cwd)
  let file_len = 0
  for f in readdir(a:cwd)
    let l = strwidth(f)
    if l > file_len
      let file_len = l
    endif
  endfor
  return file_len
endfu

fu! s:bw(file_path)
  try
    exec "bw! " .a:file_path
  catch
  endtry
endfu

fu! s:help(context) abort
  map <buffer>
endfu

fu! s:wipeout(context) abort
  let current_path_list = a:context.targets
  for current_path in current_path_list
    call <sid>bw(current_path)
  endfor
endfu

fu! s:doubleclick(context) abort
  wincmd _
endfu

fu! s:open(context) abort
  let current_path_list = a:context.targets
  let [current_path] = current_path_list[0:0]
  call defx2#defx(expand('%:p'), expand('%:p:h'))
  exec "e " .current_path
  call defx2#defx(expand('%:p'), expand('%:p:h'))
endfu

fu! s:doubleclickblank(context) abort
  wincmd l
endfu

fu! s:xxx(context) abort
  let current_path = a:context.targets[0]
  ec printf('%s', current_path)
endfu

fu! s:gettarget(targets)
  if match(trim(execute('set ft')), 'defx') == -1
    return 1
  endif
  let targets = a:targets
  let target = ''
  if len(targets) == 1
    let target = targets[0]
  endif
  return target
endfu

fu! s:changewidth(width)
  call defx#custom#option('_', {
        \ 'winwidth': a:width + 29,
        \ 'split': 'vertical',
        \ 'direction': 'topleft',
        \ 'buffer_name': '',
        \ 'toggle': 1,
        \ 'resume': 1
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': a:width,
        \ 'max_width': a:width,
        \ })
endfu

fu! s:fitwidth(context) abort
  let target = <sid>gettarget(a:context.targets)
  let cwd = a:context.cwd
  if target == 1
    return
  endif
  bw
  let file_name_len = <sid>getlongestfnamelen(cwd)
  let s:width = file_name_len + 4
  call <sid>changewidth(s:width)
  call defx2#defx(target, cwd)
endfu

fu! s:width40(context) abort
  let target = <sid>gettarget(a:context.targets)
  let cwd = a:context.cwd
  if target == 1
    return
  endif
  bw
  let s:width = 36
  call <sid>changewidth(s:width)
  call defx2#defx(target, cwd)
endfu

fu! s:width128(context) abort
  let target = <sid>gettarget(a:context.targets)
  let cwd = a:context.cwd
  if target == 1
    return
  endif
  bw
  let s:width = 128
  call <sid>changewidth(s:width)
  call defx2#defx(target, cwd)
endfu

fu! s:widthless10(context) abort
  let target = <sid>gettarget(a:context.targets)
  let cwd = a:context.cwd
  if target == 1
    return
  endif
  bw
  let s:width -= 10
  call <sid>changewidth(s:width)
  call defx2#defx(target, cwd)
endfu

fu! s:widthmore10(context) abort
  let target = <sid>gettarget(a:context.targets)
  let cwd = a:context.cwd
  if target == 1
    return
  endif
  bw
  let s:width += 10
  call <sid>changewidth(s:width)
  call defx2#defx(target, cwd)
endfu

fu! s:open()
  nnoremap <silent><buffer><expr>     <cr> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr>     o    defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr>     h    defx#is_opened_tree() ? defx#do_action('close_tree') : defx#do_action('cd', ['..'])
endfu

fu! s:cursor()
  nnoremap <silent><buffer><expr>     j    'j'
  nnoremap <silent><buffer><expr>     k    'k'
  nnoremap <silent><buffer><expr>     G    'G'
  nnoremap <silent><buffer><expr>     gg   'gg'
endfu

fu! s:path()
  nnoremap <silent><buffer><expr><nowait> yy      defx#do_action('yank_path')
  nnoremap <silent><buffer><expr><nowait> cc      defx#do_action('copy')
  nnoremap <silent><buffer><expr><nowait> c.      defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr><nowait> ch      defx#do_action('cd')
  nnoremap <silent><buffer><expr><nowait> m       defx#do_action('move')
  nnoremap <silent><buffer><expr><nowait> p       defx#do_action('paste')
  nnoremap <silent><buffer><expr><nowait> r       defx#do_action('rename')
  nnoremap <silent><buffer><expr><nowait> D       defx#do_action('remove')
  nnoremap <silent><buffer><expr><nowait> qd      defx#do_action('new_directory')
  nnoremap <silent><buffer><expr><nowait> qf      defx#do_action('new_file')
  nnoremap <silent><buffer><expr><nowait> qm      defx#do_action('new_multiple_files')
endfu

fu! s:default()
  nnoremap <silent><buffer><expr><nowait> x       defx#do_action('execute_system')
  nnoremap <silent><buffer><expr><nowait> '       defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr><nowait> A       defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr><nowait> <f5>    defx#do_action('redraw')
  nnoremap <silent><buffer><expr><nowait> .       defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr><nowait> O       defx#do_action('open_tree_recursive')
  " nnoremap <silent><buffer><expr><nowait> `       defx#do_action('repeat')
  " nnoremap <silent><buffer><expr><nowait> )       defx#do_action('resize', defx1#get_context().winwidth + 10)
  " nnoremap <silent><buffer><expr><nowait> (       defx#do_action('resize', defx1#get_context().winwidth - 10)
  " nnoremap <silent><buffer><expr><nowait> _       defx#do_action('resize', defx1#get_context().winwidth - 1)
  " nnoremap <silent><buffer><expr><nowait> +       defx#do_action('resize', defx1#get_context().winwidth + 1)
endfu

fu! s:sort()
  nnoremap <silent><buffer><expr><nowait> ;f      defx#do_action('multi', [['toggle_sort', 'filename'], 'redraw'])
  nnoremap <silent><buffer><expr><nowait> ;e      defx#do_action('multi', [['toggle_sort', 'extension'], 'redraw'])
  nnoremap <silent><buffer><expr><nowait> ;t      defx#do_action('multi', [['toggle_sort', 'time'], 'redraw'])
  nnoremap <silent><buffer><expr><nowait> ;c      defx#do_action('multi', [['toggle_sort', 'ctime'], 'redraw'])
  nnoremap <silent><buffer><expr><nowait> ;s      defx#do_action('multi', [['toggle_sort', 'size'], 'redraw'])
endfu

let s:flag1 = 1

fu! s:flag1_r()
  let s:flag1 = 1
endfu

fu! s:startfitwidth()
  if &filetype == 'defx'
    call feedkeys("\<a-o>")
  endif
  call timer_start(3000, { -> s:flag1_r() })
endfu

fu! defx1#defx_my_settings() abort
  if &filetype != 'defx'
    return
  endif
  setl number
  setl relativenumber
  setl listchars=
  call s:open()
  call s:cursor()
  call s:path()
  call s:default()
  call s:sort()
  nnoremap <silent><buffer><expr><nowait> <c-t> defx#do_action('call', '<sid>test')
  nnoremap <silent><buffer><expr><nowait> <a-o> defx#do_action('call', '<sid>fitwidth')
  nnoremap <silent><buffer><expr><nowait> <a-h> defx#do_action('call', '<sid>widthless10')
  nnoremap <silent><buffer><expr><nowait> <a-l> defx#do_action('call', '<sid>widthmore10')
  nnoremap <silent><buffer><expr><nowait> <a-i> defx#do_action('call', '<sid>width40')
  nnoremap <silent><buffer><expr><nowait> <a-u> defx#do_action('call', '<sid>width128')
  nnoremap <silent><buffer><expr><nowait> ss    defx#do_action('call', '<sid>systemstart')
  nnoremap <silent><buffer><expr><nowait> dd    defx#do_action('call', '<sid>wipeout')
  nnoremap <silent><buffer><expr><nowait> ?     defx#do_action('call', '<sid>help')
  " nnoremap <silent><buffer><expr>         sp    defx#do_action('call', '<sid>systemPaste')
  " nnoremap <silent><buffer><expr>         sc    defx#do_action('call', '<sid>systemCopy')
  " nnoremap <silent><buffer><expr>         sdd   defx#do_action('call', '<sid>deleteToRecycleBin')
  if s:flag1
    call timer_start(10, { -> s:startfitwidth() })
  endif
  let s:flag1 = 0
endfu

let s:width = 36
