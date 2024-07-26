-- General settings
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.conceallevel = 3
vim.o.ignorecase = true
vim.o.smartcase = true
vim.g.loaded_netrw = 1
vim.g.loaded_nerwPlugin = 1
vim.o.termguicolors = true

-- Keymap settings
function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command)
end

map("n", "<SPACE>", ":")
map("i", "jj", "<ESC>")
map("", "<F3>", ":NvimTreeToggle<CR>")

-- Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 
    'nvim-tree/nvim-tree.lua', 
    opts = {
      update_cwd = true,
    }
  },
  'nvim-tree/nvim-web-devicons', 
  { 
    'ryanoasis/vim-devicons',
    dependencies = {
	{
          'vim-airline/vim-airline',
          init = function()
            vim.g.airline_powerline_fonts = 1
            vim.g.airline_theme = 'sonokai'
          end
	},
      'ctrlpvim/ctrlp.vim',
    }
  },
  'vim-airline/vim-airline-themes',
  'tiagofumo/vim-nerdtree-syntax-highlight',
  'tpope/vim-fugitive',
  'scrooloose/nerdcommenter',
  'flazz/vim-colorschemes',
  'sainnhe/sonokai',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'ms-jpq/coq_nvim',
  'folke/trouble.nvim',
})

-- Colorscheme
vim.cmd 'colorscheme sonokai'

-- LSP config
require('mason').setup()
local lsp = require('lspconfig')
local coq = require('coq')
lsp.pyright.setup(coq.lsp_ensure_capabilities())

