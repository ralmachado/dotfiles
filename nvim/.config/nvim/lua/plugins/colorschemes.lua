return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      italic_comments = true,
      underline_links = true,
    },
    config = function(_, opts)
      require("vscode").setup(opts)
      vim.cmd.colorscheme "vscode"
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
