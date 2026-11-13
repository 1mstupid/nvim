local p = {
    background_low = "#1a1b26",
    background = "#24283b",
    background_high = "#3b4261",
    background_higher = "#414868",
    foreground = "#c0caf5",

    grey = "#565f89",
    dark_grey = "#3b4261",

    red = "#f7768e",
    red_dark = "${10}",

    lavender = "#7dcfff",
    lavender_dark = "${14}",

    moss = "#9ece6a",
    moss_dark = "${11}",

    green = "#7aa2f7",
    green_dark = "#9ece6a",

    yellow = "#e0af68",
    yellow_dark = "${12}",

    lime = "#7aa2f7",
    lime_dark = "${11}",
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
        bright_red = "${10}",
        bright_green = "${11}",
        bright_yellow = "${12}",
        bright_blue = "${13}",
        bright_magenta = "${14}",
        bright_cyan = "${15}",
        bright_white = "${16}",

        background = "#1a1b26",
        foreground = "#c0caf5",
    }

    return colorscheme
end

return M
