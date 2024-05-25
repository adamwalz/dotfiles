vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "custom.plugins.lazyvim" },
		{ import = "custom.plugins.colorscheme" },
		{ import = "custom.plugins.coding" },
		{ import = "custom.plugins.dap" },
		{ import = "custom.plugins.editor" },
		{ import = "custom.plugins.formatting" },
		{ import = "custom.plugins.lang" },
		{ import = "custom.plugins.linting" },
		{ import = "custom.plugins.lsp" },
		{ import = "custom.plugins.test" },
		{ import = "custom.plugins.treesitter" },
		{ import = "custom.plugins.ui" },
		{ import = "custom.plugins.utils" },
	},
	change_detection = { notify = false },
})
