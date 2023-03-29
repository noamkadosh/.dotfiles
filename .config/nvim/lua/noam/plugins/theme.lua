return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                -- transparent = true,
                lualine_bold = true,
                on_highlights = function(highlights, _)
                    highlights.gradient1 = { fg = "#1ABC9C" }
                    highlights.gradient2 = { fg = "#2EB3A5" }
                    highlights.gradient3 = { fg = "#40AAAE" }
                    highlights.gradient4 = { fg = "#53A1B6" }
                    highlights.gradient5 = { fg = "#6598BF" }
                    highlights.gradient6 = { fg = "#798EC8" }
                    highlights.gradient7 = { fg = "#8B85D0" }
                    highlights.gradient8 = { fg = "#9D7CD8" }

                    local bg = highlights.StatusLine.bg

                    highlights.StatusLineSeparator =
                        { fg = highlights.Comment.fg, bg = bg }

                    highlights.NavicIconsFile.bg = bg
                    highlights.NavicIconsModule.bg = bg
                    highlights.NavicIconsNamespace.bg = bg
                    highlights.NavicIconsPackage.bg = bg
                    highlights.NavicIconsClass.bg = bg
                    highlights.NavicIconsMethod.bg = bg
                    highlights.NavicIconsProperty.bg = bg
                    highlights.NavicIconsField.bg = bg
                    highlights.NavicIconsConstructor.bg = bg
                    highlights.NavicIconsEnum.bg = bg
                    highlights.NavicIconsInterface.bg = bg
                    highlights.NavicIconsFunction.bg = bg
                    highlights.NavicIconsVariable.bg = bg
                    highlights.NavicIconsConstant.bg = bg
                    highlights.NavicIconsString.bg = bg
                    highlights.NavicIconsNumber.bg = bg
                    highlights.NavicIconsBoolean.bg = bg
                    highlights.NavicIconsArray.bg = bg
                    highlights.NavicIconsObject.bg = bg
                    highlights.NavicIconsKey.bg = bg
                    highlights.NavicIconsKeyword.bg = bg
                    highlights.NavicIconsNull.bg = bg
                    highlights.NavicIconsEnumMember.bg = bg
                    highlights.NavicIconsStruct.bg = bg
                    highlights.NavicIconsEvent.bg = bg
                    highlights.NavicIconsOperator.bg = bg
                    highlights.NavicIconsTypeParameter.bg = bg
                    highlights.NavicText.bg = bg
                    highlights.NavicSeparator.bg = bg
                end,
            })

            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    {
        "mawkler/modicator.nvim",
        lazy = true,
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        config = function()
            require("modicator").setup({})
        end,
    },
}
