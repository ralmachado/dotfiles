return {
  {
    'Mofiqul/vscode.nvim',
    opts = {
      -- transparent = true,
      -- disable_nvimtree_bg = true
    },
    config = function(_, opts)
      require('vscode').setup(opts)
      vim.cmd.colorscheme "vscode"
    end
  },
  'sainnhe/sonokai',
  'flazz/vim-colorschemes',
}
