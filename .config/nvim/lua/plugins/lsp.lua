return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            "folke/neoconf.nvim",
            "folke/neodev.nvim",

            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            "jose-elias-alvarez/null-ls.nvim",
            "mfussenegger/nvim-dap",

            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",

            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- Language tools
            { "simrat39/rust-tools.nvim" },
            { "jose-elias-alvarez/typescript.nvim" },
            {
                "ray-x/go.nvim",
                dependencies = { "ray-x/guihua.lua" },
                ft = { "go", "gomod" },
                build = ":lua require('go.install').update_all_sync()",
            },
            { "b0o/schemastore.nvim" },

            -- Code actions
            "kosayoda/nvim-lightbulb",

            -- Hints
            "lvimuser/lsp-inlayhints.nvim",

            -- LSP Statusline Components
            "SmiteshP/nvim-navic",

            { "RRethy/vim-illuminate" },
        },
        event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
        config = function()
            local lsp = require("lsp-zero").preset({
                manage_nvim_cmp = {
                    set_format = false,
                    set_sources = "recommended",
                },
                configure_diagnostics = false,
            })

            lsp.ensure_installed({
                "cssls",
                "dockerls",
                "docker_compose_language_service",
                "gopls",
                "html",
                "jsonls",
                "lua_ls",
                "marksman",
                "nil_ls",
                "rust_analyzer",
                "tailwindcss",
                "tsserver",
                "yamlls",
            })

            lsp.set_sign_icons({
                error = " ",
                warn = " ",
                hint = " ",
                info = " ",
            })

            lsp.on_attach(function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end

                vim.keymap.set("n", "<leader>tc", function()
                    local _, float_winid = vim.diagnostic.open_float(
                        nil,
                        { focusable = true, source = true }
                    )

                    if float_winid == nil then
                        return
                    end

                    vim.api.nvim_set_current_win(float_winid)
                end, { desc = "Current line diagnostics pop up" })

                require("lsp-inlayhints").on_attach(client, bufnr)

                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({
                        filter = function(lsp_client)
                            return lsp_client.name == "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end, { desc = "Format" })
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.skip_server_setup({
                "rust_analyzer",
                "tsserver",
                "gopls",
                "lua_ls",
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

            require("plugins.tools.language_tools").setup_language_tools(
                lsp
            )

            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
            })

            vim.diagnostic.config({
                signs = {
                    severity = {
                        min = vim.diagnostic.severity.HINT,
                    },
                },
                virtual_text = {
                    severity = {
                        min = vim.diagnostic.severity.WARN,
                        source = "if_many",
                    },
                },
                underline = true,
                severity_sort = true,
                update_in_insert = true,
            })
        end,
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

    {
        "lvimuser/lsp-inlayhints.nvim",
        lazy = true,
        config = function()
            require("lsp-inlayhints").setup({
                inlay_hints = {
                    parameter_hints = {
                        prefix = " <- ",
                    },
                    type_hints = {
                        prefix = " => ",
                    },
                    highlight = "Comment",
                },
            })
        end,
    },
}
