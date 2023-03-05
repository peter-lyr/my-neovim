augroup Binary
  au!
  au BufReadPre  * call binxxd#readPre()
  au BufReadPost * call binxxd#readPost()
augroup END
