version = "0.21.1"
local xplr = xplr
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

xplr.config.general.show_hidden = true

require("xpm").setup({
	plugins = {
		-- Let xpm manage itself
		"dtomvan/xpm.xplr",
		"sayanarijit/alacritty.xplr",
		"sayanarijit/find.xplr",
		"sayanarijit/fzf.xplr",
		"sayanarijit/map.xplr",
		"sayanarijit/xclip.xplr",
		"sayanarijit/zoxide.xplr",
		"gitlab:hartan/web-devicons.xplr",
	},
	auto_install = true,
	auto_cleanup = true,
})

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
	help = "xpm",
	messages = {
		"PopMode",
		{ SwitchModeCustom = "xpm" },
	},
}

xplr.config.node_types.directory.meta.icon = xplr.util.paint(" ")
