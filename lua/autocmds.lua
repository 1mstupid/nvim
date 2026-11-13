local theme_file = "/home/waltz/Projects/nvim/lua/colorscheme.lua"

local function reload_theme()
	-- Clear Lua module cache
	package.loaded["colorscheme"] = nil

	-- Reload the module
	local ok, theme = pcall(require, "colorscheme")

	if not ok then
		vim.notify("Theme reload failed:\n" .. theme, vim.log.levels.ERROR)
		return
	end

	-- Reapply your colorscheme
	-- Replace this with your actual colorscheme application function
	require("colors.waltz").setup(theme.pick())

	vim.notify("Theme reloaded!", vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = theme_file,
	callback = reload_theme,
})

_G.reload_theme = reload_theme
-- Highlight the current line on only the active buffer
local cursorline_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursorline_group,
	pattern = "*",
	command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = cursorline_group,
	pattern = "*",
	command = "setlocal nocursorline",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})
