local keymap = vim.keymap

keymap.set('i', 'df', '<esc>')
keymap.set('i', 'df', '<esc>')
keymap.set('i', 'df', '<esc>')
keymap.set('i', 'df', '<esc>')
keymap.set('t', 'df', '<c-\\><c-n>')
keymap.set('t', 'df', '<c-\\><c-n>')
keymap.set('t', 'df', '<c-\\><c-n>')
keymap.set('t', 'df', '<c-\\><c-n>')
keymap.set('t', '<esc>', '<c-\\><c-n>')
keymap.set('t', '<a-m>', '<c-\\><c-n>')
keymap.set('v', 'm', '<esc>')

keymap.set('n', '<a-y>', '"+y')
keymap.set('v', '<a-y>', '"+y')
keymap.set('n', '<a-p>', '"+p')
keymap.set('n', '<a-s-p>', '"+p')
keymap.set('v', '<a-p>', '"+p')
keymap.set('v', '<a-s-p>', '"+p')

keymap.set({'n', 'i'}, '<rightmouse>', '<leftmouse>')
keymap.set({'n', 'i'}, '<rightrelease>', '<nop>')

keymap.set('n', '<leader>f.', '<cmd>:if (&ft == "vim" || &ft == "lua") | source %:p | endif<cr>')

keymap.set('n', 'c.', '<cmd>:try|cd %:h|catch|endtry<cr>', {silent = true})
keymap.set('n', 'cu', '<cmd>:try|cd ..|catch|endtry<cr>', {silent = true})
keymap.set('n', 'c-', '<cmd>:try|cd -|catch|endtry<cr>', {silent = true})

keymap.set('n', 'q', '<nop>')
keymap.set('n', 'q', 'q')

keymap.set('n', 'u', '<c-r>')

keymap.set('n', '<c-s>', '5<c-e>')
keymap.set('n', '<c-a>', '5<c-y>')
keymap.set('n', '<c-d>', '<c-u>')
keymap.set('n', '<c-f>', '<c-d>')
keymap.set('n', '<c-u>', '<c-b>')
keymap.set('n', '<c-b>', '<c-f>')

keymap.set('n', '<leader>ba', '<c-w>s')
keymap.set('n', '<leader>bb', '<cmd>:new<cr>')

keymap.set('n', '<leader>bc', '<c-w>v')
keymap.set('n', '<leader>bd', '<cmd>:vnew<cr>')

keymap.set('n', '<leader>be', '<c-w>s<c-w>t')
keymap.set('n', '<leader>bf', '<cmd>:tabnew<cr>')

keymap.set('n', '<leader>w', '<c-w>k')
keymap.set('v', '<leader>w', '<c-w>k')
keymap.set('n', '<leader>s', '<c-w>j')
keymap.set('v', '<leader>s', '<c-w>j')
keymap.set('n', '<leader>a', '<c-w>h')
keymap.set('v', '<leader>a', '<c-w>h')
keymap.set('n', '<leader>d', '<c-w>l')
keymap.set('v', '<leader>d', '<c-w>l')
keymap.set('n', '<cr>', '<cmd>:tabnext<cr>')
keymap.set('n', '<s-cr>', '<cmd>:tabprevious<cr>')
