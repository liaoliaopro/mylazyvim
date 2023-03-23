return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "black",
        "flake8",
        "pyright",
        "gopls",
        "rust-analyzer",
      },
    },
  },
}
