return {
  -- Code diagnostics
  { 
    "folke/trouble.nvim", 
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Toggle diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Trouble: Toggle symbols" },
    },
  },

  -- Git gutter signs and hunk edit/commit
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({"]c", bang = true})
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Gitsigns: Next hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({"[c", bang = true})
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Gitsigns: Prev hunk" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Gitsigns: Stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Gitsigns: Reset hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Gitsigns: Stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Gitsigns: Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Gitsigns: Preview hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Gitsigns: Preview hunk (inline)" })
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Gitsigns: Blame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Gitsigns: Diff this" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Gitsigns: Diff this (~)" })

        -- Toggles
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Gitsigns: Toggle line blame" })
        map("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "Gitsigns: Toggle deleted" })
        map("n", "<leader>gtw", gitsigns.toggle_word_diff, { desc = "Gitsigns: Toggle word diff" })

        -- Text object
        map({"o", "x"}, "ih", gitsigns.select_hunk)
      end
    }
  },

  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "TODO Comments: Next" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "TODO Comments: Next" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble: Toggle TODO" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Picker: TODO comments" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Picker: TODO/FIX/FIXME" },
    },
  },

  -- Rainbow delimiters
  {
    "hiphish/rainbow-delimiters.nvim",
  }
}

