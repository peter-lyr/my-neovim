local status, hop = pcall(require, "hop")
if not status then
  return
end

hop.setup{}

vim.keymap.set("n", "gi", "<cmd>:HopChar1MW<cr>")
vim.keymap.set("n", "go", "<cmd>:HopChar2MW<cr>")
