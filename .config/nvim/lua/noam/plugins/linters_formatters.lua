return {
    {
        "jay-babu/mason-null-ls.nvim",
        lazy = true,
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true,
                automatic_setup = false,
            })
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.stylua,
                    require("typescript.extensions.null-ls.code-actions"),
                },
            })
        end,
    },
}
