return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    enabled = true,
    dependencies = { 
      "nvim-lua/plenary.nvim",

      -- Plugins
      "tsakirist/telescope-lazy.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      -- find
      {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find files"},
      {"<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Telescope: Config files"},
      {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live grep"},
      {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope: Buffers"},
      {"<leader>fr", "<cmd>Telescope frecency<cr>", desc = "Telescope: Buffers"},

      -- git
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git: Branches" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git: Status" },

      -- grep
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      -- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      --
      -- LSP
      -- { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "LSP: Diagnostics", mode = { "n", "x" } },
      -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP: Symbols" },
      -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP: Goto Definition" },
      -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP: Goto Declaration" },
      -- { "gr", function() Snacks.picker.lsp_references() end, desc = "LSP: References" },
      -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP: Goto Implementation" },
      -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP: Goto Type Definition" },
      --
      -- -- search
      -- { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      -- { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Picker: Show pickers" },
      --
      -- -- misc
      -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Picker: Colorschemes" },
      -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications" },
      -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    },
    opts = {
      pickers = {
        find_files = {
          -- Follow symlinks
          follow = true,
        },
        live_grep = {
          additional_args = { "-L" },
        },
      },
    },
    config = function(_, opts)
      local t = require("telescope")
      t.setup(opts)
      t.load_extension "lazy"
      t.load_extension "frecency"
    end
  },
}
