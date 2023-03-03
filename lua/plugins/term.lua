return {
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>fx", "<cmd>ToggleTerm<cr>", desc = "Terminal (toggle)" },
    },
    opts = {
      direction = "vertical",
      size = vim.o.columns * 0.4,
    },
  },
}
