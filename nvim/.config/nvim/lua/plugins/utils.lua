return {
  "wesQ3/vim-windowswap",
  "tpope/vim-repeat",

  -- render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    cmd = {
      "ToggleTerm",
      "TermExec",
    },
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm: floating term" },
      { "<leader>tg", "<cmd>TermExec cmd=lazygit direction=float<cr>", desc = "ToggleTerm: lazygit" },
    }
  },

  -- EasyMotion
  {
    "easymotion/vim-easymotion",
    event = "VeryLazy"
  },

  -- Soft-wrapping toggle
  { 
    "andrewferrier/wrapping.nvim",
    event = "VeryLazy",
    opts = {}
  },

  -- VimTex
  {
    "lervag/vimtex",
    init = function()
      -- PDF viewer: Okular
      -- vim.g.vimtex_view_general_viewer = "okular"
      -- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
      -- PDF viewer: Zathura
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_open_on_warning = 0
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

