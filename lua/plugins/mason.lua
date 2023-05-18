return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "mypy",
        "black",
        "ruff-lsp",
        "python-lsp-server",
        "gopls",
        "rust-analyzer",
      },
    },
  },
}
