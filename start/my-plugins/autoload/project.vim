let s:autorootflag = 1

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

fu! s:escape_slash(abspath)
  return substitute(a:abspath, '/', '\', 'g')
endfu

fu! s:parent_dir(abspath, level=1)
  if !s:is_existed(a:abspath)
    return 'cd'
  endif
  let level = a:level
  let abspath = s:escape_slash(a:abspath)
  let list = split(trim(abspath, '\', 2), '\')
  let length = len(list)
  if level > length - 1
    let level = length - 1
  endif
  return join(list[:length-level-1], '\')
endfu

fu! project#toggle()
  let s:autorootflag = !s:autorootflag
  call project#root()
  try
    call timer_stop(g:nvimtreetimer)
  catch
  endtry
  if s:autorootflag == 1
    echomsg 'ProjectRootCD auto'
    let g:nvimtreetimer = timer_start(10, { -> nvimtree#do() }, {'repeat': -1})
  else
    echomsg 'ProjectRootCD manual'
  endif
endfu

fu! project#start()
  LspStart clangd
endfu

fu! project#startproj()
  lua << EOF
    while vim.lsp.client_is_stopped(vim.g.my_client_id) == 0 do
    end
EOF
  if index(['c', 'cpp', 'h'], &ft) != -1
    call timer_start(100, { -> project#start() })
  endif
endfu

fu! project#root()
  let cwd = getcwd()
  if s:autorootflag
    try
      let s = split(nvim_buf_get_name(0), ':')
      if len(s) > 1 && len(s[0]) == 1
        exec printf('cd %s:\', s[0])
        exec printf('cd %s',
							\ join(split(substitute(nvim_buf_get_name(0),
							\ '/', '\', 'g'), '\')[:-2], '\'))
      endif
    catch
    endtry
    try
      ProjectRootCD
    catch
    endtry
  endif
  let &titlestring = getcwd()
  if cwd != getcwd()
    lua << EOF
    local clients = vim.lsp.get_active_clients(nil)
    if #clients >= 1 then
      vim.g.my_client_id = clients[1].id
      vim.cmd [[
        LspStop clangd
        call timer_start(10, { -> project#startproj() })
      ]]
    else
      vim.cmd [[
        if index(['c', 'cpp', 'h'], &ft) != -1
          LspStart clangd
        endif
      ]]
    end
EOF
  endif
  if expand('%:p:t') == 'index.md'
    lua require('mkdnflow').initial_dir = vim.fn['expand']('%:p:h')
  else
    let path = substitute(nvim_buf_get_name(0), '/', '\', 'g')
    if filereadable(path) && (!exists("g:my_index_dir") || match(path, substitute(g:my_index_dir, '\', '\\\\', "g")) == -1)
      while match(path, '\') != -1
        let path = s:parent_dir(path)
        if filereadable(printf('%s\index.md', path))
          let g:my_index_dir = path
          lua require('mkdnflow').initial_dir = vim.g.my_index_dir
          break
        endif
      endwhile
    endif
  endif
endfu
