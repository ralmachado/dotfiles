return {
  {
    "morhetz/gruvbox",
    lazy = true,
    enabled = false,
  },
  {
    "joshdick/onedark.vim",
    lazy = true,
    enabled = false,
  },
  {
    "KeitaNakamura/neodark.vim",
    lazy = true,
    enabled = false,
  },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require("vscode").setup({
        italic_comments = true,
        underline_links = true,
        disable_nvimtree_bg = true,
        terminal_colors = true,
      })
      vim.cmd.colorscheme "vscode"
    end,
  },
  {
    "tinted-theming/tinted-vim",
    lazy = true,
    enabled = false,
  },
  { 
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    enabled = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme "oxocarbon"
    -- end
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    enabled = false,
  },
}
