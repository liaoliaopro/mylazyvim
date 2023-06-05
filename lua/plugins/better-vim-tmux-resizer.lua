return {
  {
    "RyanMillerC/better-vim-tmux-resizer",

    keys = {
      { "<C-Left>", "<Cmd>TmuxResizeLeft<Cr>" },
      { "<C-Right>", "<Cmd>TmuxResizeRight<Cr>" },
      { "<C-Up>", "<Cmd>TmuxResizeUp<Cr>" },
      { "<C-Down>", "<Cmd>TmuxResizeDown<Cr>" },
    },
    opts = {
      tmux_resizer_no_mappings = 1,
    },
  },
}
