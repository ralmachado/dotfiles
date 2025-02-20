return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',

      -- Plugins
      'tsakirist/telescope-lazy.nvim',
    },
    cmd = 'Telescope',
    keys = {
      {'<C-p>', '<cmd>Telescope find_files<cr>', desc = "Telescope: Find files"},
      {'<leader>fg', '<cmd>Telescope live_grep<cr>', desc = "Telescope: Live grep"},
      {'<leader>fb', '<cmd>Telescope buffers<cr>', desc = "Telescope: Buffers"},
    }
  }
}
