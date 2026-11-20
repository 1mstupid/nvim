local p = {
	background_low = "#002b36",
	background = "#073642",
	background_high = "#586e75",
	background_higher = "#002b36",
	foreground = "#839496",

	grey = "#657b83",
	dark_grey = "#586e75",

	red = "#dc322f",
	red_dark = "#cb4b16",

	lavender = "#cb4b16",
	lavender_dark = "#6c71c4",

	moss = "#859900",
	moss_dark = "#586e75",

	green = "#268bd2",
	green_dark = "#859900",

	yellow = "#b58900",
	yellow_dark = "#657b83",

	lime = "#268bd2",
	lime_dark = "#586e75",
}

local M = {}

function M.pick()
	local colorscheme = vim.deepcopy(p)

	colorscheme.terminal = {
		black = "#073642",
		red = "#dc322f",
		green = "#859900",
		yellow = "#b58900",
		blue = "#268bd2",
		magenta = "#d33682",
		cyan = "#2aa198",
		white = "#eee8d5",

		bright_black = "#002b36",
		bright_red = "#cb4b16",
		bright_green = "#586e75",
		bright_yellow = "#657b83",
		bright_blue = "#839496",
		bright_magenta = "#6c71c4",
		bright_cyan = "#93a1a1",
		bright_white = "#fdf6e3",

		background = "#002b36",
		foreground = "#839496",
	}

	return colorscheme
end

return M
