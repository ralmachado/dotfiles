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
vim.g.mapleader = ","

-- Keymap settings
function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command)
end

map("n", "<SPACE>", ":")
map("i", "jj", "<ESC>")
map("", "<F3>", ":NvimTreeToggle<CR>")
map("n","<leader>n", ":tabn<CR>")
map("n","<leader>p", ":tabp<CR>")

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
require("lazy").setup("plugins")

-- LSP config
require('lspconfig').ruff.setup {}
require('lspconfig').basedpyright.setup {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        ignore = { '*' },
      },
    },
  },
}
