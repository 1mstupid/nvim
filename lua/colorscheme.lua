local p = {
	background_low = "#1a1b26",
	background = "#24283b",
	background_high = "#3b4261",
	background_higher = "#414868",
	foreground = "#c0caf5",

	grey = "#565f89",
	dark_grey = "#3b4261",

	red = "#f7768e",
	red_dark = "#f7768e",

	lavender = "#7dcfff",
	lavender_dark = "#bb9af7",

	moss = "#9ece6a",
	moss_dark = "#9ece6a",

	green = "#7aa2f7",
	green_dark = "#9ece6a",

	yellow = "#e0af68",
	yellow_dark = "#e0af68",

	lime = "#7aa2f7",
	lime_dark = "#9ece6a",
}

local M = {}

function M.pick()
	local colorscheme = vim.deepcopy(p)

	colorscheme.terminal = {
		black = "#15161e",
		red = "#f7768e",
		green = "#9ece6a",
		yellow = "#e0af68",
		blue = "#7aa2f7",
		magenta = "#bb9af7",
		cyan = "#7dcfff",
		white = "#a9b1d6",

		bright_black = "#414868",
		bright_red = "#f7768e",
		bright_green = "#9ece6a",
		bright_yellow = "#e0af68",
		bright_blue = "#7aa2f7",
		bright_magenta = "#bb9af7",
		bright_cyan = "#7dcfff",
		bright_white = "#c0caf5",

		background = "#1a1b26",
		foreground = "#c0caf5",
	}

	return colorscheme
end

return M
