return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "black",
        "ruff",
        "ruff-lsp",
        "pyright",
        "gopls",
        "rust-analyzer",
      },
    },
  },
}
