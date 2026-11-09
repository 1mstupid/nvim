-- Cursor
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkon6",
}

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Scrolling
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
	lead = " ",
	trail = " ",
	tab = "  ╎",
}

-- General
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.isfname:append("@-@")
