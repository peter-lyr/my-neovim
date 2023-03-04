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
