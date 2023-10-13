return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
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
