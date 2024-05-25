return {
	"LazyVim/LazyVim",
	import = "lazyvim.plugins",
	priority = 10000,
	lazy = false,
	cond = true,
	version = "*",
	opts = {
		colorscheme = function()
			require("catppuccin").load()
		end,
		defaults = {
			autocmds = false,
			keymaps = false,
		},
		news = {
			lazyvim = false,
			neovim = false,
		},
		icons = {},
		kind_filter = {},
	},
}
