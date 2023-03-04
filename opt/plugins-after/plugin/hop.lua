local status, hop = pcall(require, "hop")
if not status then
  return
end

hop.setup{}

vim.keymap.set("n", "gi", "<cmd>:HopChar1MW<CR>")
vim.keymap.set("n", "go", "<cmd>:HopChar2MW<CR>")
