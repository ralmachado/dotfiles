return {
  -- zen-mode
  {
    "folke/zen-mode.nvim",
    opts = {}
  },

  -- nvim-tree
  { 
    "nvim-tree/nvim-tree.lua", 
    enabled = false,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<F3>", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree: Toggle" },
    },
    opts = {
      sync_root_with_cwd = true,
      view = {
        float = {
          enable = false,
        },
      },
      renderer = {
        hidden_display = "all",
        highlight_opened_files = "icon",
        highlight_modified = "icon",
      },
      modified = {
        enable = true,
      },
      filters = {
        custom = {
          "^.git$",
          "^.vscode$",
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', "<C-.>", api.tree.change_root_to_node, opts("CD"))
      end,
    },
  },
  
  -- lualine
  { 
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { 
        theme = "auto",
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
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "BufferLine: Close ungrouped" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "BufferLine: Close buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "BufferLine: Close buffers to the left" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "BufferLine: Close other buffers" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "BufferLine: Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "BufferLine: Next buffer" },
      { "<[b>", "<cmd>BufferLineCyclePrev<cr>", desc = "BufferLine: Prev buffer" },
      { "<]b>", "<cmd>BufferLineCycleNext<cr>", desc = "BufferLine: Next buffer" },
      { "<[B>", "<cmd>BufferLineMovePrev<cr>", desc = "BufferLine: Move buffer prev" },
      { "<]B>", "<cmd>BufferLineMoveNext<cr>", desc = "BufferLine: Move buffer next" },
    },
    opts = {
      options = {
        -- Use snacks.nvim bufdelete
        close_command = function(n) MiniBufremove.delete(n) end,
        right_mouse_command = function(n) MiniBufremove.delete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        show_tab_indicators = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = '󰙅  File Explorer',
            text_align = "center",
            separator = true,
          },
          {
            filetype = "snacks_layout_box",
            text = '󰙅  File Explorer',
            separator = true,
          },
        },
      }
    },
    init = function ()
      vim.o.termguicolors = true
    end,
    config = true,
  },

  -- snacks
  {
    "snacks.nvim",
    opts = {
      bigfile = {},
      quickfile = {},
      -- indent = {},
      input = {},
      notifier = {},
      scope = {},
      scroll = {},
      statuscolumn = {},
      dashboard = {},
    },
  },
}
