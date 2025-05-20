return {
  {
    "snacks.nvim",
    enabled = true,
    opts = {
      -- picker = {},
      -- image = {},
      -- explorer = {
      --   hidden = true,
      --   ignored = true,
      --   exclude = { ".git" },
      -- },
    },
    keys = {
      -- find
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Picker: Find File"},
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Picker: Find Config File"},
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Picker: Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Picker: Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Picker: Recent Files" },

      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git: Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git: Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git: Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git: Diff (Hunks)" },

      -- grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

      -- LSP
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "LSP: Diagnostics", mode = { "n", "x" } },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP: Symbols" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP: Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP: Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, desc = "LSP: References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP: Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP: Goto Type Definition" },

      -- search
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Picker: Show pickers" },

      -- misc
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Picker: Colorschemes" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    },
    actions = require("trouble.sources.snacks").actions,
    win = {
      input = {
        keys = {
          ["<c-t>"] = {
            "trouble_open",
            mode = { "n", "i" },
          },
        },
      },
    },
  }
}
