local config_root = "/home/waltz/Projects/nvim"
local theme_file = config_root .. "/lua/colorscheme.lua"

local function reload_theme()
	-- Ensure the development config is in runtimepath
	vim.opt.runtimepath:prepend(config_root)

	-- Invalidate the palette cache
	package.loaded["colorscheme"] = nil

	-- Reload the colorscheme directly
	local ok, err = pcall(function()
		dofile(config_root .. "/colors/waltz.lua")
	end)

	if not ok then
		vim.notify("Theme reload failed:\n" .. err, vim.log.levels.ERROR)
		return
	end

	vim.notify("Theme reloaded!", vim.log.levels.INFO)
end

local watcher = vim.uv.new_fs_event()

watcher:start(config_root .. "/lua", {}, function(err, filename)
	if err or filename ~= "colorscheme.lua" then
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
