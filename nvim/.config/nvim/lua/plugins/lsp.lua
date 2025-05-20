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

  -- LuaSnip
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "VeryLazy",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "micangl/cmp-vimtex",
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local lspconfig = require("lspconfig")
      local ls = require("luasnip")
      cmp.setup {
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
            ls.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "vimtex" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if ls.expand_or_locally_jumpable() then
              ls.expand_or_jump()
            elseif cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif ls.locally_jumpable(1) then
              ls.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif ls.locally_jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }

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
