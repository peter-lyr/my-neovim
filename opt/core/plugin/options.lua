local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- title
opt.title = true

-- updatetime
opt.updatetime = 0

-- winheight
opt.winminheight = 0
opt.winminwidth = 0

--tabs & indentation
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

--line wrapping
opt.wrap = false

-- search settings
-- opt.ignorecase = true
opt.smartcase = true

--cursor line
opt.cursorline = true

--appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

--split windows
opt.splitright = true
opt.splitbelow = true

opt.mousemodel = "extend"

opt.swapfile = false

opt.iskeyword = '@,48-57,_,192-255'

opt.fileformats = 'dos'
