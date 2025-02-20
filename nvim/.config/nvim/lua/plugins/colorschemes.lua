return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme vscode'
    end
  },
  {
    "tinted-theming/tinted-vim",
    lazy = true,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
  },
}
