-- General settings
--- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_nerwPlugin = 1
--- General editor settings
vim.o.encoding = "utf-8"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.conceallevel = 2
vim.o.clipboard = "unnamedplus"
--- Change leader
vim.g.mapleader = " "

-- Keymap settings
function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command)
end
--- Motion through soft wrap
map("n", "j", "gj")
map("n", "k", "gk")
map("i", "jj", "<ESC>")

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
