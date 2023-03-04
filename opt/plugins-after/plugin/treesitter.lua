local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

vim.opt.runtimepath:append(vim.fn.expand("$VIMRUNTIME") .. "\\my-nvim-data\\treesitter-parser")

treesitter.setup {
  ensure_installed = { "c", "lua", "markdown", "vim", "python", },
  sync_install = false,
  auto_install = true,
  -- ignore_install = { "javascript" },
  parser_install_dir = vim.fn.expand("$VIMRUNTIME") .. "\\my-nvim-data\\treesitter-parser",

  highlight = {
    enable = true,
    -- disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>qi",
      node_incremental = "<leader>qi",
      scope_incremental = "<leader>qu",
      node_decremental = "<leader>qo",
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}

vim.cmd [[
set foldmethod=indent
" set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.
]]

local status, treesitter_context = pcall(require, "treesitter-context")
if not status then
  return
end

treesitter_context.setup({})
