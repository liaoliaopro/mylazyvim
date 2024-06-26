return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "rest-nvim/rest.nvim",

        keys = {
            { "<leader>hr", ":Rest run<cr>",      desc = "Rest run" },
            { "<leader>hl", ":Rest run last<cr>", desc = "Rest re-run last" },
        },
        ft = "http",
        dependencies = { "luarocks.nvim" },
        config = function()
            require("rest-nvim").setup()
        end,
    }
}
