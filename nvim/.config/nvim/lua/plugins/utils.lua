return {
  "tpope/vim-fugitive",
  "wesQ3/vim-windowswap",
  "tpope/vim-repeat",
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },

  { "nvim-lua/plenary.nvim", lazy=True },

  { 
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "which-key: Buffer Local Keymaps" }
    },
  },
}
