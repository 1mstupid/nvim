local config_root = vim.env.CONFIG_ROOT

if config_root then
	vim.opt.runtimepath:prepend(config_root)

	package.path = config_root .. "/lua/?.lua;" .. config_root .. "/lua/?/init.lua;" .. package.path
end

require("waltz").setup({
	theme = "auto",
	transparent = true,
	italics = {
		comments = false,
		keywords = true,
		functions = true,
		strings = false,
		variables = true,
	},
})
