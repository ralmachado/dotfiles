return {
  -- lsp-signature
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {}
  },

  -- nvim-lightbulb
  { 
    "kosayoda/nvim-lightbulb",
    event = "InsertEnter",
    opts = {
      autocmd = { enabled = true }
    }
  },

  -- LSP management
  { 
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", 
    },
    config = function()
      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = { "basedpyright", "ruff" },
      }
    end,
  },

  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "micangl/cmp-vimtex",
      "onsails/lspkind.nvim",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local lspconfig = require("lspconfig")
      local ls = require("luasnip")
      
      -- Setup LuaSnip
      ls.setup {
        history = true,
        delete_check_events = "TextChanged"
      }
      
      -- Setup friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

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
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
        }
      }
    end
  },

  -- lspconfig
  { 
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.enable("tflint")
      vim.lsp.enable("terraformls")
      vim.lsp.enable("cfn-lint")
      vim.lsp.config("cfn-lint", {capabilities=capabilities})
      vim.lsp.enable("prettierd")
      vim.lsp.config("prettierd", {capabilities=capabilities})
      vim.lsp.enable("typescript-language-server")
      vim.lsp.config("typescript-language-server", {capabilities=capabilities})
      vim.lsp.enable("ruff")
      vim.lsp.config("ruff", {
        capabilities = capabilities
      })
      vim.lsp.enable("basedpyright")
      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            disableOrganizeImports = True,
            analysis = {
                typeCheckingMode = "basic",
            },
          },
        },
      })
    end
  },

  -- conform.nvim
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
      },
    },
    keys = {
      { "<leader>gw", function() require("conform").format({ async = true }) end, desc = "Format buffer" }
    }
  }
}
