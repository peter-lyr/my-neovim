fu! filebrowser#cur()
	try
		exec printf('cd %s:\', expand('%:p')[0])
		cd %:h
	catch
	endtry
	let &titlestring = getcwd()
endfu

fu! filebrowser#up()
	try
		cd ..
	catch
	endtry
	let &titlestring = getcwd()
endfu

fu! filebrowser#toggle()
	try
		cd -
	catch
	endtry
	let &titlestring = getcwd()
endfu

fu! filebrowser#proj()
	try
		exec 'ProjectRoot'
	catch
	endtry
	let &titlestring = getcwd()
	ec getcwd()
endfu

fu! filebrowser#startcur()
	try
		exec printf('silent !start %s', expand('%:h'))
	catch
	endtry
endfu

fu! filebrowser#startproj()
	try
		exec printf('silent !start %s', getcwd())
	catch
	endtry
endfu

fu! filebrowser#opencur()
	let fname = nvim_buf_get_name(0)
	if filereadable(fname)
		try
			exec printf('silent !start %s', fname)
		catch
		endtry
	endif
endfu
