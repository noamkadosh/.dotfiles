return {
    "theprimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- There is a problem in alacritty where the Alt (Option) key is not working properly
        -- The appropriate keymap is commented out
        -- (https://github.com/alacritty/alacritty/issues/62)
        -- (https://github.com/alacritty/alacritty/issues/93)
        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "´", ui.toggle_quick_menu) -- <A-e>

        vim.keymap.set("n", "˙", function() ui.nav_file(1) end) -- <A-h>
        vim.keymap.set("n", "†", function() ui.nav_file(2) end) -- <A-t>
        vim.keymap.set("n", "˜", function() ui.nav_file(3) end) -- <A-n>
        vim.keymap.set("n", "ß", function() ui.nav_file(4) end) -- <A-s>
        require("which-key").register({
            ["<leader>a"] = "Add file to harpoon",
            ["´"] = "Toggle harpoon panel",
            ["˙"] = "Navigate to file 1",
            ["†"] = "Navigate to file 2",
            ["˜"] = "Navigate to file 3",
            ["ß"] = "Navigate to file 4",
        })

    end,
  }
