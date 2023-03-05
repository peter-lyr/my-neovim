local status1, mason = pcall(require, "mason")
if not status1 then
  return
end

local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
  return
end

local status3, lspconfig = pcall(require, "lspconfig")
if not status3 then
  return
end

local status4, lspsaga = pcall(require, "lspsaga")
if not status4 then
  return
end


-- mason
mason.setup({
  install_root_dir = vim.fn.expand("$VIMRUNTIME") .. "\\my-nvim-data\\mason",
})

mason_lspconfig.setup({
  ensure_installed = {
    "clangd",
  }
})


-- lspsaga
lspsaga.setup({
  move_in_saga = { prev = "<A-k>", next = "<A-j>" },
  finder_action_keys = {
    open = "<CR>",
  },
  definition_action_keys = {
    edit = "<CR>",
  },
})


-- lspconfig
local status5, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status5 then
  print('no cmp_nvim_lsp!')
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local util = require'lspconfig.util'

local clangd_root_dir = function(fname)
  local root_files = {
    ".cache",
    "build",
    "compile_commands.json",
    "CMakeLists.txt",
    ".git",
    ".svn",
  }
  return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end,

lspconfig["clangd"].setup({
  capabilities = capabilities,
  root_dir = clangd_root_dir,
  single_file_support = false,
})
