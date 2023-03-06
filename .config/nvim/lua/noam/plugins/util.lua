return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        config = function()
            require("project_nvim").setup({
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = {
                    "lazy-lock.json",
                    ".git",
                    "cargo.toml",
                    "package.json",
                },
                ignore_lsp = {},
                exclude_dirs = {},
                show_hidden = false,
                silent_chdir = true,
                datapath = vim.fn.stdpath("data"),
            })
        end,
    },

    {
        "folke/neoconf.nvim",
        lazy = true,
        cmd = "Neoconf",
        config = true,
    },

    {
        "folke/neodev.nvim",
        lazy = true,
        opts = {
            experimental = { pathStrict = true },
        },
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end,
    },
}
