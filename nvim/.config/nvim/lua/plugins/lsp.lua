return {
  -- LSP management
  { "williamboman/mason.nvim", opts = {} },
  { 
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "basedpyright", "ruff" },
    },
  },
  { "neovim/nvim-lspconfig" },

  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local lspconfig = require("lspconfig")
      cmp.setup({
        sorting = {
          comparators = {
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              require "cmp-under-comparator".under,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
          },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol"
          },
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = True }),
        },
        sorting
      })

      -- LSP setup
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.ruff.setup { capabilities = capabilities }
      lspconfig.basedpyright.setup { 
        settings = {
          basedpyright = {
            disableOrganizeImports = True,
            analysis = {
              ignore = { "*" },
            },
          },
        },
        capabilities = capabilities,
      }
    end
  },
}
