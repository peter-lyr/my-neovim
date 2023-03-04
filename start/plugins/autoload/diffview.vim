fu! diffview#FileHistory()
  if &modifiable == 0
    return
  endif
  DiffviewFileHistory
endfu

fu! diffview#OpenFocusFiles()
  if &modifiable == 0
    DiffviewFocusFiles
  else
    DiffviewOpen -u
  endif
endfu

fu! diffview#Close()
  let bufs = []
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    let fname = nvim_buf_get_name(bnum)
    if len(fname) > 0 && match(fname, '[\/]\.git[\/]') != -1
      if index(bufs, bnum) == -1
        let bufs += [bnum]
      endif
    endif
  endfor
  if &modifiable == 0 || &foldmethod == 'diff'
    let tabs = tabpagenr('$')
    let cur_tab = tabpagenr()
    DiffviewClose
    if cur_tab < tabs && tabs != tabpagenr('$')
      norm gT
    endif
  endif
  for buf in bufs
    try
      exec printf("%dbw!", buf)
      wincmd p
    catch
    endtry
  endfor
endfu

let s:rev1 = ''
let s:rev2 = ''

fu! s:clr1()
  let s:rev1 = ''
endfu

fu! s:clr2()
  let s:rev1 = ''
endfu

fu! diffview#bin(dir, path, context)
  if len(s:rev1) == 0
    let s:rev1 = a:context
    call timer_start(1000, { -> s:clr1() })
  else
    let s:rev2 = a:context
    call timer_start(1000, { -> s:clr2() })
    let fname = printf("%s%s", substitute(a:dir, '.git$', '', ''), a:path)
    " d:\gittest\qwer>git difftool --tool=bc4 -y 5797b26..be1f181 d:\gittest\app.bin
    let cmd = printf("silent !start /MIN git difftool --tool=bc4 -y %s..%s %s", s:rev1, s:rev2, fname)
    exec cmd
  endif
endfu

let g:counttoggle = 1

fu! diffview#counttoggle()
  lua << EOF
    if vim.g.counttoggle == 1 then
      vim.g.counttoggle = 0
      print(32768)
      require("diffview").setup({
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                max_count = 32768,
              },
              multi_file = {
                max_count = 32768,
              },
            },
          }
        }
      })
    else
      vim.g.counttoggle = 1
      print(8)
      require("diffview").setup({
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                max_count = 8,
              },
              multi_file = {
                max_count = 8,
              },
            },
          }
        }
      })
    end
EOF
endfu

" diffview.nvim\lua\diffview\vcs\file.lua
  " if not config.get_config().diff_binaries and self.binary then
  "   local context
  "   if self.rev.type == RevType.COMMIT then
  "     context = self.rev:abbrev(7)
  "   elseif self.rev.type == RevType.STAGE then
  "     context = (":%d:"):format(self.rev.stage)
  "   elseif self.rev.type == RevType.CUSTOM then
  "     context = "[custom]"
  "   end
  "   vim.fn['diffview#bin'](self.adapter.ctx.dir, self.path, context)
  " end

