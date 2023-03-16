return {
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        config = function()
            local lsp = require("lsp-zero")
            local rt = require("rust-tools")

            local rust_lsp = lsp.build_options("rust_analyzer", {
                single_file_support = false,
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { desc = "", buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set(
                        "n",
                        "<Leader>a",
                        rt.code_action_group.code_action_group,
                        { desc = "", buffer = bufnr }
                    )
                end,
            })

            rt.setup({
                tools = {
                    inlay_hints = {
                        parameter_hints_prefix = " <- ",
                        other_hints_prefix = " => ",
                    },
                },
                server = { rust_lsp },
            })
        end,
    },

    {
        "jose-elias-alvarez/typescript.nvim",
        lazy = true,
        config = function()
            require("typescript").setup({
                disable_commands = false,
            })
        end,
    },

    {
        "ray-x/go.nvim",
        lazy = true,
        dependencies = {
            { "ray-x/guihua.lua" },
        },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        config = function()
            require("go").setup({})
        end,
    },
}
