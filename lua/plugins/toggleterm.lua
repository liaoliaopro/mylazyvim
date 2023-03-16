return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<C-\>]] },
    { "<leader>fx", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
  },
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    -- direction = "float",
    -- size = 20,
    direction = "vertical",
    size = vim.o.columns * 0.5,
    hide_numbers = true,
    open_mapping = [[<C-\>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3,
    start_in_insert = true,
    persist_size = true,
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end,
    },
  },
}
