local theme_file = "/home/waltz/Projects/nvim/lua/colorscheme.lua"

local function reload_theme()
	package.loaded["colorscheme"] = nil

	local ok, err = pcall(function()
		require("waltz").colorscheme()
	end)

	if not ok then
		vim.notify("Theme reload failed:\n" .. err, vim.log.levels.ERROR)
		return
	end

	vim.notify("Theme reloaded!", vim.log.levels.INFO)
end

local watcher = vim.uv.new_fs_event()

watcher:start(theme_file, {}, function(err)
	if err then
		return
	end

	vim.schedule(reload_theme)
end)

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
