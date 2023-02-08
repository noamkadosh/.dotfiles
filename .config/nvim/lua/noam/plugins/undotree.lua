return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        require("which-key").register({
            ["<leader>u"] = "Toggle undotree panel",
        })
    end
}
