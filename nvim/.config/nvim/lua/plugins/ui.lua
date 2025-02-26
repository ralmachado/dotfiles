return {
  -- nvim-tree
  { 
    "nvim-tree/nvim-tree.lua", 
    lazy = False,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sync_root_with_cwd = true,
    }
  },
  
  -- lualine
  { 
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { 
        theme = "vscode",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      extensions = { "nvim-tree", "fugitive", "lazy", "mason", "trouble" },
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
    end
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "BufferLine: Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose unpinned<cr>", desc = "BufferLine: Close unpinned" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "BufferLine: Close buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "BufferLine: Close buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "BufferLine: Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "BufferLine: Next buffer" },
      { "<[b>", "<cmd>BufferLineCyclePrev<cr>", desc = "BufferLine: Prev buffer" },
      { "<]b>", "<cmd>BufferLineCycleNext<cr>", desc = "BufferLine: Next buffer" },
      { "<[B>", "<cmd>BufferLineMovePrev<cr>", desc = "BufferLine: Move buffer prev" },
      { "<]B>", "<cmd>BufferLineMoveNext<cr>", desc = "BufferLine: Move buffer next" },
    },
    opts = {
      options = {
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            text_align = "left",
            separator = true,
          },
        },
      }
    },
    init = function ()
      vim.o.termguicolors = true
    end
  },

  -- snacks
  {
    "snacks.nvim",
    opts = {
      bigfile = {},
      quickfile = {},
      indent = {},
      input = {},
      notifier = {},
      scope = {},
      scroll = {},
      statuscolumn = {},
      dashboard = {},
    },
  },
}
