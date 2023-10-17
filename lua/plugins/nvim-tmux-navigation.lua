return {
  {
    "alexghergh/nvim-tmux-navigation",

    keys = {
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<Cr>" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<Cr>" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<Cr>" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<Cr>" },
      { "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<Cr>" },
      -- { "<C-Space>", "<Cmd>NvimTmuxNavigateNext<Cr>" },
    },
    opts = {
      disable_when_zoomed = true,
    },
  },
}
