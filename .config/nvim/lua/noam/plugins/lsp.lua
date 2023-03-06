return {
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "folke/neoconf.nvim",
            "folke/neodev.nvim",
            "williamboman/mason.nvim",

            -- Language tools
            "simrat39/rust-tools.nvim",
            "jose-elias-alvarez/typescript.nvim",
            "ray-x/go.nvim",
            { "b0o/schemastore.nvim" },

            "hrsh7th/nvim-cmp",

            -- LSP Icons
            { "SmiteshP/nvim-navic" },
        },
        event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
        config = function()
            local lsp = require("lsp-zero")

            lsp.preset("recommended")

            lsp.ensure_installed({
                "eslint",
                "gopls",
                "jsonls",
                "lua_ls",
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = "E",
                    warn = "W",
                    hint = "H",
                    info = "I",
                },
            })

            lsp.on_attach(function(client, bufnr)
                local opts = {
                    buffer = bufnr,
                    remap = false,
                }

                if client.name == "eslint" then
                    vim.cmd.LspStop("eslint")
                    return
                end

                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                -- TODO: add remap descriptions
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end)

            -- Fix Undefined global "vim"
            lsp.configure("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            })

            lsp.configure("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })

            lsp.setup()

            require("noice").setup({
                lsp = {
                    override = {
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                            ["vim.lsp.util.stylize_markdown"] = true,
                            ["cmp.entry.get_documentation"] = true,
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        lazy = true,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            { "neovim/nvim-lspconfig" },
        },
    },
}
