fu! buffers1#copycurpath()
  let s:openpath = nvim_buf_get_name(0)
endfu

fu! buffers1#openhere()
  try | exec printf("e %s", s:openpath) | catch | endtry
endfu

fu! buffers1#openright()
  try | exec printf("vnew|e %s", s:openpath) | catch | endtry
endfu

fu! buffers1#opendown()
  try | exec printf("new|e %s", s:openpath) | catch | endtry
endfu
