return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local helpers = require("noam.plugins.tools.helpers")

            local hero = {
                [[  ██████   █████                   █████   █████  ███                  ]],
                [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
                [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
                [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
                [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
                [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
                [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
                [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
            }

            local heading = helpers.assignGradientColors(hero)
            heading = helpers.header_color(heading)

            local section_info = {
                type = "text",
                val = helpers.info_text(),
                opts = {
                    hl = "Comment",
                    position = "center",
                },
            }

            local section_shortcuts =
                { type = "group", val = helpers.shortcuts }

            local padding = { type = "padding", val = 1 }
            local double_padding = { type = "padding", val = 2 }

            local theme = require("alpha.themes.theta")
            local dashboard = require("alpha.themes.dashboard")
            local config = theme.config

            local recent_files = config.layout[4]
            local quick_links = config.layout[6]

            recent_files.val[1].val = "󱋡  Recent Files"
            recent_files.val[2] = padding
            recent_files.val[3] = {
                type = "group",
                val = function()
                    return { theme.mru(0, vim.fn.getcwd(), 5) }
                end,
                opts = { shrink_margin = false },
            }
            quick_links.val[1].val = "  Quick Actions"
            quick_links.val[4] = dashboard.button("SPC p f", "󰈞  Find file")
            quick_links.val[5] = dashboard.button("SPC p s", "󰊄  Live grep")
            quick_links.val[6] = dashboard.button("c", "󰒓  Configuration")
            quick_links.val[7] = dashboard.button(
                "u",
                "󰚰  Update plugins",
                "<cmd>Lazy update<CR>",
                { desc = "Update plugins" }
            )
            table.remove(quick_links.val, 8)
            table.insert(
                quick_links.val,
                3,
                dashboard.button("SPC p v", "󰥨  File explorer")
            )
            table.insert(
                quick_links.val,
                3,
                dashboard.button(
                    "SPC o s",
                    "󰪺  Restore current cwd last session"
                )
            )
            table.insert(
                quick_links.val,
                3,
                dashboard.button("SPC o l", "󰅒  Restore last session")
            )

            local section_projects = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = "󰪺   Recent Projects",
                        opts = {
                            hl = "SpecialComment",
                            shrink_margin = false,
                            position = "center",
                        },
                    },
                    padding,
                    {
                        type = "group",
                        val = helpers.get_recent_projects,
                    },
                },
            }

            config.layout[2] = heading
            config.layout[3] = double_padding
            config.layout[4] = section_shortcuts
            config.layout[5] = padding
            config.layout[6] = section_info
            config.layout[7] = double_padding
            config.layout[8] = recent_files
            config.layout[9] = padding
            config.layout[10] = section_projects
            config.layout[11] = padding
            config.layout[12] = quick_links

            require("alpha").setup(config)
        end,
    },
}
