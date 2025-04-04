return {
  "tpope/vim-fugitive",
  "wesQ3/vim-windowswap",
  "tpope/vim-repeat",
  { 
    "andrewferrier/wrapping.nvim",
    opts = {}
  },

  -- VimTex
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
      vim.g.vimtex_fold_enabled = 1
    end
  },

  -- Plenary lib
  { "nvim-lua/plenary.nvim", lazy=True },

  -- Which-Key
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

  -- Snacks bufdelete
  {
    "snacks.nvim",
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Close other buffers" }
    },
  },
}

