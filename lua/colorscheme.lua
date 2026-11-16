local p = {
    background_low = "#282828",
    background = "#3c3836",
    background_high = "#504945",
    background_higher = "#928374",
    foreground = "#ebdbb2",

    grey = "#928374",
    dark_grey = "#504945",

    red = "#fb4934",
    red_dark = "#fb4934",

    lavender = "#8ec07c",
    lavender_dark = "#d3869b",

    moss = "#98971a",
    moss_dark = "#b8bb26",

    green = "#fabd2f",
    green_dark = "#98971a",

    yellow = "#d79921",
    yellow_dark = "#fabd2f",

    lime = "#fabd2f",
    lime_dark = "#b8bb26",
}

local M = {}

function M.pick()
    local colorscheme = vim.deepcopy(p)

    colorscheme.terminal = {
        black = "#282828",
        red = "#cc241d",
        green = "#98971a",
        yellow = "#d79921",
        blue = "#458588",
        magenta = "#b16286",
        cyan = "#689d6a",
        white = "#a89984",

        bright_black = "#928374",
        bright_red = "#fb4934",
        bright_green = "#b8bb26",
        bright_yellow = "#fabd2f",
        bright_blue = "#83a598",
        bright_magenta = "#d3869b",
        bright_cyan = "#8ec07c",
        bright_white = "#ebdbb2",

        background = "#282828",
        foreground = "#ebdbb2",
    }

    return colorscheme
end

return M
