return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local noice = require("noice")

        require('lualine').setup({
            options = {
                theme = 'tokyonight',
            },
            sections = {
                lualine_x = {
                    {
                        noice.api.status.message.get_hl,
                        cond = noice.api.status.message.has,
                    },
                    {
                        noice.api.status.command.get,
                        cond = noice.api.status.command.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        noice.api.status.mode.get,
                        cond = noice.api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        noice.api.status.search.get,
                        cond = noice.api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_y = { 'progress', 'location' },
                lualine_z = {
                    function()
                        local day = tonumber(os.date("%d"):match("^%d*"))
                        local hour = tonumber(os.date("%I"))
                        local dateTime = " " .. os.date("%a, %b ") .. day ..
                            (day % 10 == 1 and day % 100 ~= 11 and "st" or
                                (day % 10 == 2 and day % 100 ~= 12 and "nd" or
                                    (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th"))) ..
                            "  " .. hour .. os.date(":%M %p")
                        return dateTime
                    end,
                },
            }
        })
    end
}
