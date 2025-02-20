return {
  { 
    "nvim-tree/nvim-tree.lua", 
    lazy = False,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sync_root_with_cwd = true,
    }
  },
  { 
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto" },
      extensions = { "nvim-tree", "fugitive", "lazy", "mason", "trouble" }
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
    end
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "BufferLine: Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose<cr>", desc = "BufferLine: Close unpinned" },
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
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_alignt = "left",
            separator = true,
          },
        },
      }
    },
    init = function ()
      vim.o.termguicolors = true
    end
  },
}
