local M = {}

-- TODO: Refactor this function, code uses pretty much the same patterns and probably can be generalized. Also should fix bg color of icons.
function M.lsp_breakdown()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })

    if #clients == 0 then
        return
    end

    local status = {}
    local web_devicons = require("nvim-web-devicons")

    for _, client in pairs(clients) do
        if client.config.name == "copilot" then
            table.insert(status, "%#CmpItemKindCopilot# %#StatusLine#" .. client.name)
        elseif client.config.name == "null-ls" then
            table.insert(status, "%#Constant#󱁤 %#StatusLine#" .. client.name)
        elseif client.config.name == "tsserver" then
            local icon = web_devicons.get_icon("ts") .. " "

            table.insert(status, "%#DevIconTs#" .. icon .. "%#StatusLine#" .. client.name)
        elseif client.config.name == "eslint" then
            table.insert(status, "%#TSRainbowViolet#󰱺 %#StatusLine#" .. client.name)
        elseif client.config.name == "tailwindcss" then
            table.insert(status, "%#rainbowcol4#󱏿 %#StatusLine#" .. client.name)
        elseif client.config.name == "stylelint_lsp" then
            table.insert(status, "%#rainbowcol4# %#StatusLine#" .. client.name)
        elseif client.config.filetypes == nil then
            table.insert(status, client.name)
        elseif client.config.filetypes[1] == "rust" then
            local icon = web_devicons.get_icon("rs") .. " "

            table.insert(status, "%#DevIconRs#" .. icon .. "%#StatusLine#" .. client.name)
        elseif client.config.filetypes[1] == "typescript" then
            local icon = web_devicons.get_icon("ts") .. " "

            table.insert(status, "%#DevIconTs#" .. icon .. "%#StatusLine#" .. client.name)
        elseif client.config.filetypes[1] == "typescriptreact" then
            local icon = web_devicons.get_icon("tsx") .. " "

            table.insert(status, "%#DevIconTsx#" .. icon .. "%#StatusLine#" .. client.name)
        elseif client.config.filetypes[1] == "javascript" then
            local icon = web_devicons.get_icon("js") .. " "

            table.insert(status, "%#DevIconJs#" .. icon .. "%#StatusLine#" .. client.name)
        elseif client.config.filetypes[1] == "javascriptreact" then
            local icon = web_devicons.get_icon("jsx") .. " "

            table.insert(status, "%#DevIconJsx#" .. icon .. "%#StatusLine#" .. client.name)
        else
            local icon = web_devicons.get_icon(client.config.filetypes[1]) .. " "

            table.insert(
                status,
                "%#DevIcon"
                .. (client.config.filetypes[1]:gsub("^%l", string.upper))
                .. "#"
                .. icon
                .. "%#StatusLine#"
                .. client.name
            )
        end
    end

    return "    " .. table.concat(status, "%#StatusLineSeparator# · %#StatusLine#")
end

function M.assignGradientColors(lines)
    local out = {}
    for i, line in ipairs(lines) do
        local hi = "gradient"
        hi = hi .. (((i + 7) % 8) + 1)
        table.insert(out, { hi = hi, line = line })
    end
    return out
end

function M.header_color(heading)
    local lines = {}
    for _, lineConfig in pairs(heading) do
        local hi = lineConfig.hi
        local line_chars = lineConfig.line
        local line = {
            type = "text",
            val = line_chars,
            opts = {
                hl = hi,
                shrink_margin = false,
                position = "center",
            },
        }
        table.insert(lines, line)
    end

    local output = {
        type = "group",
        val = lines,
        opts = { position = "center" },
    }

    return output
end

local function getDate()
    local day = tonumber(os.date("%d"):match("^%d*"))
    local dateTime = " "
        .. os.date("%A, %B ")
        .. day
        ..
        (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
        .. os.date(" %Y")

    return dateTime
end

function M.info_text()
    local total_plugins = require("lazy").stats().count
    local datetime = getDate()
    local version = vim.version()
    local nvim_version_info = ""

    if version ~= nil then
        nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    end

    return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

function M.shortcuts()
    local keybind_opts = { silent = true, noremap = true }
    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "AlphaReady" },
        callback = function(_)
            vim.api.nvim_buf_set_keymap(0, "n", "z", "<cmd>Lazy<CR>", keybind_opts)
            vim.api.nvim_buf_set_keymap(0, "n", "p", "<cmd>Telescope projects<CR>", keybind_opts)
            vim.api.nvim_buf_set_keymap(0, "n", "r", "<cmd>e ~/.config/nvim/lua/noam/remap.lua<CR>", keybind_opts)
            vim.api.nvim_buf_set_keymap(0, "n", "s", "<cmd>e ~/.config/nvim/lua/noam/set.lua<CR>", keybind_opts)
            vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", keybind_opts)
        end,
    })
    return {
        {
            type = "text",
            val = {
                " Lazy [z]     Project [p]    󰅱 Remaps [r]    󰒓 Settings [s]     Quit [q]",
            },
            opts = {
                position = "center",
                hl = {
                    { "String",      1,  18 },
                    { "PreProc",     18, 36 },
                    { "Function",    36, 54 },
                    { "Constant",    54, 74 },
                    { "rainbowcol1", 74, 100 },
                },
            },
        },
    }
end

function M.open_project(project_path)
    local project_nvim = require("project_nvim.project")
    local success = project_nvim.set_pwd(project_path, "alpha")
    if not success then
        return
    end
    require("telescope.builtin").find_files({
        cwd = project_path,
    })
end

function M.get_recent_projects(start, target_width)
    local project_nvim = require("project_nvim")
    if start == nil then
        start = 1
    end
    if target_width == nil then
        target_width = 50
    end
    local buttons = {}
    local project_paths = project_nvim.get_recent_projects()
    local added_projects = 0
    for i = #project_paths, 1, -1 do
        if added_projects == 5 then
            break
        end
        local project_path = project_paths[i]
        ---@diagnostic disable-next-line: undefined-field
        local stat = vim.loop.fs_stat(project_path .. "/.git")
        if stat ~= nil and stat.type == "directory" then
            added_projects = added_projects + 1
            local shortcut = tostring(added_projects + 4)
            local display_path = "  " .. string.gsub(project_path, vim.env.HOME, "~")
            local path_ok, plenary_path = pcall(require, "plenary.path")
            if #display_path > target_width and path_ok then
                display_path = plenary_path.new(display_path):shorten(1, { -2, -1 })
                if #display_path > target_width then
                    display_path = plenary_path.new(display_path):shorten(1, { -1 })
                end
            end
            buttons[added_projects] = {
                type = "button",
                val = display_path,
                on_press = function()
                    M.open_project(project_path)
                end,
                opts = {
                    position = "center",
                    shortcut = shortcut,
                    cursor = target_width,
                    width = target_width,
                    align_shortcut = "right",
                    hl_shortcut = "Keyword",
                    hl = { { "Function", 1, 3 }, { "Comment", 4, #string.match(display_path, ".*[/\\]") } },
                    keymap = {
                        "n",
                        shortcut,
                        "<cmd>lua require('noam.helpers').open_project('" .. project_path .. "')<CR>",
                        { noremap = true, silent = true, nowait = true },
                    },
                },
            }
        end
    end
    return buttons
end

function M.has_words_before()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

function M.capitalize(str)
    return str:gsub("(%l)(%w*)", function(a, b)
        return string.upper(a) .. b
    end)
end

return M
