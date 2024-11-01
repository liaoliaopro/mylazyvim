return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "toml",
        "svelte",
        "css",
        "http",
        "json",
        "proto",
        "hurl",
      })
    end,
  },
}
