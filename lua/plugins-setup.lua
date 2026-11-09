local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	root = vim.fn.stdpath("data") .. "/waltz/lazy",

	defaults = {
		lazy = true,
	},

	install = {
		missing = true,
	},

	change_detection = {
		notify = false,
	},

	rocks = {
		enabled = false,
	},

	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"netrw",
				"matchit",
				"matchparen",
				"vimball",
				"vimballPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
