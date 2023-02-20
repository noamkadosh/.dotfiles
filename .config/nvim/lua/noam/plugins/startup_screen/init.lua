return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        require("alpha").setup(require("noam.plugins.startup_screen.alpha"))
    end
}
