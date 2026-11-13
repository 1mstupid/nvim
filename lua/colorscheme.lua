local p = {
	background_low = "#191724",
	background = "#1f1d2e",
	background_high = "#26233a",
	background_higher = "#6e6a86",
	foreground = "#e0def4",

	grey = "#6e6a86",
	dark_grey = "#26233a",

	red = "#eb6f92",
	red_dark = "#eb6f92",

	lavender = "#f6c177",
	lavender_dark = "#c4a7e7",

	moss = "#31748f",
	moss_dark = "#31748f",

	green = "#9ccfd8",
	green_dark = "#31748f",

	yellow = "#f6c177",
	yellow_dark = "#f6c177",

	lime = "#9ccfd8",
	lime_dark = "#31748f",
}

local M = {}

function M.pick()
	local colorscheme = vim.deepcopy(p)

	colorscheme.terminal = {
		black = "#26233a",
		red = "#eb6f92",
		green = "#31748f",
		yellow = "#f6c177",
		blue = "#9ccfd8",
		magenta = "#c4a7e7",
		cyan = "#ebbcba",
		white = "#e0def4",

		bright_black = "#6e6a86",
		bright_red = "#eb6f92",
		bright_green = "#31748f",
		bright_yellow = "#f6c177",
		bright_blue = "#9ccfd8",
		bright_magenta = "#c4a7e7",
		bright_cyan = "#ebbcba",
		bright_white = "#908caa",

		background = "#191724",
		foreground = "#e0def4",
	}

	return colorscheme
end

return M
