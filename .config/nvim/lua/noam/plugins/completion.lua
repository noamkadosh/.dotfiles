return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "petertriho/cmp-git" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            "zbirenbaum/copilot.lua",

            -- LSP Icons
            { "onsails/lspkind.nvim" },
        },
        config = function()
            local cmp = require("cmp")
            local helpers = require("noam.plugins.tools.helpers")

            local cmp_select = {
                behavior = cmp.SelectBehavior.Select,
            }

            local cmp_mappings = {
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<Tab>"] = vim.schedule_wrap(function(fallback)
                    if cmp.visible() and helpers.has_words_before() then
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Select,
                        })
                    else
                        fallback()
                    end
                end),
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                preselect = "none",
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp_mappings,
                sources = cmp.config.sources({
                    {
                        name = "copilot",
                    },
                    {
                        name = "nvim_lsp",
                    },
                    {
                        name = "luasnip",
                    },
                }, {
                    {
                        name = "buffer",
                    },
                    {
                        name = "path",
                    },
                }),
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        menu = {
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        },
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = {
                            Copilot = "",
                        },
                    }),
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,
                    },
                },
            })

            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {
                fg = "#6CC644",
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources(
                    { {
                        name = "cmp_git",
                    } },
                    { {
                        name = "buffer",
                    } }
                ),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { {
                    name = "buffer",
                } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { {
                        name = "path",
                    } },
                    {
                        {
                            name = "cmdline",
                            option = {
                                ignore_cmds = {
                                    "q",
                                    "qa",
                                    "w",
                                    "wq",
                                    "x",
                                    "xa",
                                    "cq",
                                    "cqa",
                                    "cw",
                                    "cwq",
                                    "cx",
                                    "cxa",
                                },
                            },
                        },
                    }
                ),
            })
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false,
                },
                panel = {
                    enabled = false,
                },
            })

            require("copilot_cmp").setup({})
        end,
    },
}
