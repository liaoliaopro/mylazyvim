return {
    {
        "aserowy/tmux.nvim",

        keys = {
            { "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>" },
            { "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>" },
            { "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>" },
            { "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>" },
            { "<M-h>", "<cmd>lua require'tmux'.resize_left()<cr>" },
            { "<M-j>", "<cmd>lua require'tmux'.resize_bottom()<cr>" },
            { "<M-k>", "<cmd>lua require'tmux'.resize_top()<cr>" },
            { "<M-l>", "<cmd>lua require'tmux'.resize_right()<cr>" },
        },
        opts = {
        },
    },
}
