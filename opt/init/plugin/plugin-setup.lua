local fn = vim.fn
local cmd = vim.cmd
local keymap = vim.keymap

local ensure_packer = function()
  local install_path = fn.expand('$VIMRUNTIME') .. '\\pack\\packer\\start\\packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('git clone packer.nvim...')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print('clone dnoe!')
    cmd('packadd packer.nvim')
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, 'packer')
if not status then
  return
end

packer.init({
  package_root = fn.expand('$VIMRUNTIME') .. '\\pack',
  compile_path = fn.expand('$VIMRUNTIME') .. '\\plugin'
})

local plugins = function(use)
  use('dstein64/vim-startuptime')

  use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' })

  use('907th/vim-auto-save')
  use('xolox/vim-misc')
  use('xolox/vim-session')

  use('rafi/awesome-vim-colorschemes')
  use('EdenEast/nightfox.nvim')
  use('folke/tokyonight.nvim')

  use("nvim-tree/nvim-tree.lua")
  use("Shougo/defx.nvim")

  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")
  use("sindrets/diffview.nvim")
  use("kyazdani42/nvim-web-devicons")

  use("tpope/vim-surround")
  use("preservim/nerdcommenter")
  use("windwp/nvim-autopairs")
  use('skywind3000/asyncrun.vim')
  use({ 'phaazon/hop.nvim', branch = 'v2' })
  use("azabiong/vim-highlighter")
  use("bitc/vim-bad-whitespace")
  use("dstein64/nvim-scrollview")

  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/nvim-treesitter-context")

  use("lukas-reineke/indent-blankline.nvim")

  use("peter-lyr/my-terminal")
  use("peter-lyr/my-replace")
  use("peter-lyr/my-telescope-extension")
  use("peter-lyr/my-markdown")
  use("peter-lyr/vim-get-blocks")
  use("peter-lyr/my-translate")

  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end
  })

  use("dbakker/vim-projectroot")
  use("ahmedkhalf/project.nvim")
  use("MattesGroeger/vim-bookmarks")
  use("tom-anders/telescope-vim-bookmarks.nvim")

end

return packer.startup(function(use)
  use('wbthomason/packer.nvim')
  use('nvim-lua/plenary.nvim')

  plugins(use)

  if packer_bootstrap then
    print('packer sync...')
    require('packer').sync()
    print('sync done!')
  end
end)
