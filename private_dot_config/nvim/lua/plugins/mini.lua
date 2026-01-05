return {
  { 
    "nvim-mini/mini.nvim", 
    version = false,
    config = function()
      require('mini.extra').setup()
      require('mini.pick').setup()
      require('mini.ai').setup()
      require('mini.move').setup()
      require('mini.pairs').setup()
      -- require('mini.comment').setup()
      require('mini.indentscope').setup()
      require('mini.git').setup()
      require('mini.surround').setup()
      require('mini.files').setup()
      require('mini.icons').setup()
      require('mini.bufremove').setup()
      require('mini.keymap').setup()
      require('mini.jump2d').setup()
      require('mini.sessions').setup()
      require('mini.basics').setup({
        options = {
          extra_ui = true,
        },
        mappings = {
          windows = true,
          move_with_alt = true,
        }
      })

      -- mini.files
      vim.keymap.set('n', '<F3>', function() MiniFiles.open() end)
      
      -- mini.keymap
      ---- Multistep actions
      local map_multistep = require('mini.keymap').map_multistep
      map_multistep('i', '<BS>',    { 'hungry_bs', 'minipairs_bs' })
      map_multistep('i', '<CR>',    { 'cmp_accept', 'minipairs_cr' })
      map_multistep('i', '<Tab>',   { 'increase_indent', 'cmp_next' })
      map_multistep('i', '<S-Tab>', { 'decrease_indent', 'cmp_prev' })
      
      ---- Combo keymaps
      local map_combo = require('mini.keymap').map_combo
      local mode = { "i", "c", "x", "s" }
      map_combo(mode, "jk", "<BS><BS><ESC>")
      map_combo("t",  "jk", "<BS><BS><C-\\><C-n>")
      map_combo("t",  "kj", "<BS><BS><C-\\><C-n>")
    end,
  },
}
