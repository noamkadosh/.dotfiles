return {
    {
        "tpope/vim-fugitive",
        lazy = true,
        init = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git" })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 0,
            },
            current_line_blame_formatter = function(_, blame_info, _)
                local helpers = require("noam.plugins.tools.helpers")

                local day = tonumber(
                    os.date("%d", blame_info.author_time):match("^%d*")
                )
                local hour = tonumber(os.date("%I", blame_info.author_time))
                local dateTime = os.date("%a, %b ", blame_info.author_time)
                    .. day
                    .. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
                    .. os.date(" %Y ", blame_info.author_time)
                    .. hour
                    .. os.date(":%M %p", blame_info.author_time)
                local blame = "    by "
                    .. helpers.capitalize(blame_info.author)
                    .. " - at "
                    .. dateTime
                    .. ": "
                    .. blame_info.summary

                return { { blame, "Comment" } }
            end,
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "契" },
                topdelete = { text = "契" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function()
                    gs.blame_line({ full = true })
                end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function()
                    gs.diffthis("~")
                end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },
}
