return {
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = function()
            require("twilight").setup({})
        end,
    },

    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            vim.keymap.set(
                "n",
                "<leader>z",
                vim.cmd.ZenMode,
                { desc = "Zen Mode" }
            )
            require("zen-mode").setup({
                plugins = {
                    alacritty = {
                        enabled = true,
                        font = "22",
                    },
                },
            })
        end,
    },

    { "tpope/vim-repeat" },

    {
        "echasnovski/mini.ai",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.ai").setup({})
        end,
    },

    {
        "echasnovski/mini.surround",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.surround").setup({})
        end,
    },

    {
        "echasnovski/mini.pairs",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.pairs").setup({})
        end,
    },
}
