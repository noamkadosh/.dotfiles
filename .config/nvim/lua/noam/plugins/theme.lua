return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                transparent = true,
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
