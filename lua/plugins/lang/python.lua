return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        -- nls.builtins.formatting.ruff,
        nls.builtins.formatting.black,
        -- nls.builtins.diagnostics.ruff,
      })
      nls.builtins.formatting.black.with({
        extra_args = { "--line-length=88" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                flake8 = { enabled = false },
                autopep8 = { enabled = false },
                black = { enabled = true },
                ruff = {
                  enabled = true,
                  extendSelect = { "I" },
                },
                mypy = {
                  enabled = true,
                  live_mode = true,
                  strict = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
