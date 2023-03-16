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
            "kosayoda/nvim-lightbulb",

            -- LSP Statusline Components
            "SmiteshP/nvim-navic",

            { "RRethy/vim-illuminate" },
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
                    error = " ",
                    warn = " ",
                    hint = " ",
                    info = " ",
                },
            })

            lsp.on_attach(function(client, bufnr)
                local opts = {
                    buffer = bufnr,
                    remap = false,
                }

                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = function()
                        vim.diagnostic.open_float(nil, { focusable = false })
                    end,
                    group = diag_float_grp,
                })

                vim.keymap.set(
                    "n",
                    "<leader>vd",
                    vim.lsp.buf.definition,
                    { unpack(opts), desc = "Jump to definition of symbol under the cursor" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vD",
                    vim.lsp.buf.declaration,
                    { unpack(opts), desc = "Jump to declaration of symbol under the cursor" }
                )
                vim.keymap.set(
                    "n",
                    "K",
                    vim.lsp.buf.hover,
                    { unpack(opts), desc = "Dispaly hover info about symbol under the cursor" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vws",
                    vim.lsp.buf.workspace_symbol,
                    { unpack(opts), desc = "Search symbol in workspace" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vd",
                    vim.diagnostic.open_float,
                    { unpack(opts), desc = "Dispaly diagnostics in a floating window" }
                )
                vim.keymap.set(
                    "n",
                    "[d",
                    vim.diagnostic.goto_next,
                    { unpack(opts), desc = "Move to prev diagnostic in current buffer" }
                )
                vim.keymap.set(
                    "n",
                    "]d",
                    vim.diagnostic.goto_prev,
                    { unpack(opts), desc = "Move to next diagnostic in current buffer" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vc",
                    vim.lsp.buf.code_action,
                    { unpack(opts), desc = "Select a code action available in the under the current cursor position" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vr",
                    vim.lsp.buf.references,
                    { unpack(opts), desc = "List all references to the symbol under the cursor" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>vn",
                    vim.lsp.buf.rename,
                    { unpack(opts), desc = "Renames all references to the symbol under the cursor" }
                )
                vim.keymap.set(
                    "i",
                    "<C-k>",
                    vim.lsp.buf.signature_help,
                    { unpack(opts), desc = "Dispaly signature info about symbol under the cursor in a floating window" }
                )
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
                    telemetry = {
                        enable = false,
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

    {
        "kosayoda/nvim-lightbulb",
        lazy = true,
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
                sign = {
                    enabled = true,
                    priority = 10,
                },
            })

            vim.fn.sign_define("LightBulbSign", {
                text = "󱠂",
                texthl = "@string.documentation",
            })
        end,
    },
}
