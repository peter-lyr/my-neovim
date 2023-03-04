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

fu! s:system_cd(absfolder)
  if !isdirectory(a:absfolder)
    return ''
  endif
  return a:absfolder[0] .': && cd ' .a:absfolder
endfu

fu! s:get_used_file(fname)
  return expand('$VIMRUNTIME') .'\pack\my-neovim\opt\my-files\' .a:fname
endfu

fu! mygit#addCommitPush()
  try
    cd %:p:h
  catch
  endtry
  call terminal#runShow(
        \ s:system_cd(getcwd())
        \ .' && '
        \ .s:get_used_file('git\add-commit-push.bat')
        \ )
  norm i
endfu

fu! mygit#run(cmd)
  silent exec printf("!start cmd /c \"%s\"", a:cmd)
endfu

fu! mygit#initdo(path)
  let path = a:path
	let dirname = '.git-' .split(path, '\')[-1]
  call terminal#runShow(
        \ s:system_cd(path)
        \ .' && '
        \ .s:get_used_file('git\git-init.bat')
				\ .' ' .dirname
        \ )
  let fname = path .'\' .'.gitignore'
  if filereadable(fname)
    let lines = readfile(fname)
    if index(lines, dirname) == -1
      call writefile([dirname], fname, "a")
    endif
  else
    call writefile([dirname], fname, "a")
  endif
endfu

fu! mygit#init()
  try
    cd %:p:h
  catch
  endtry
  let list = []
  let path = substitute(nvim_buf_get_name(0), '/', '\', 'g')
  let path = substitute(path, '/', '\', 'g')
  while match(path, '\') != -1
    let path = s:parent_dir(path)
    let list += [path]
  endwhile
  call telescope_extension#sel('git root', list, 'mygit#initdo')
endfu

fu! mygit#commitPush()
  try
    cd %:p:h
  catch
  endtry
  call terminal#runShow(
        \ s:system_cd(getcwd())
        \ .' && '
        \ .s:get_used_file('git\commit-push.bat')
        \ )
  norm i
endfu

fu! mygit#justPush()
  try
    cd %:p:h
  catch
  endtry
  call terminal#runShow(
        \ s:system_cd(getcwd())
        \ .' && '
        \ .s:get_used_file('git\just-push.bat')
        \ )
  norm i
endfu

fu! mygit#addCommit()
  try
    cd %:p:h
  catch
  endtry
  call terminal#runShow(
        \ s:system_cd(getcwd())
        \ .' && '
        \ .s:get_used_file('git\add-commit.bat')
        \ )
  norm i
endfu

fu! mygit#justCommit()
  try
    cd %:p:h
  catch
  endtry
  call terminal#runShow(
        \ s:system_cd(getcwd())
        \ .' && '
        \ .s:get_used_file('git\just-commit.bat')
        \ )
  norm i
endfu

fu! mygit#wait()
  try
    if match(nvim_buf_get_name(0), 'HEAD\~1:') == -1
      Gitsigns diffthis HEAD~1
    else
      call timer_stop(s:timer)
    endif
    if match(nvim_buf_get_name(0), 'HEAD\~1:') != -1
      call timer_stop(s:timer)
    endif
  catch
    close
  endtry
endfu

fu! mygit#diffview(fname)
  new
  exec printf("silent e %s", a:fname)
  let fname = substitute(a:fname, '/', '\', 'g')
  let s:timer = timer_start(100, { -> mygit#wait() }, {'repeat': -1})
endfu

fu! mygit#diff()
  let list = split(trim(execute(printf("!git diff HEAD~1 --name-only")), '\n'))
  if len(list) <= 4
    return
  endif
  let list = list[4:]
  call telescope_extension#sel('diff view', list, 'mygit#diffview')
endfu

fu! mygit#graph()
  silent exec printf('!start cmd /c "git log --all --graph --decorate --oneline && pause"')
endfu
