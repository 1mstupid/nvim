vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set
local options = { noremap = true, silent = true }

-- Navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Quickfix list
local function toggle_qf()
	local win_id = vim.fn.getqflist({ winid = 0 }).winid

	if win_id ~= nil and win_id ~= 0 then
		vim.cmd("ccl")
	else
		vim.cmd("copen")
		vim.cmd("wincmd p")
	end
end

map("n", "<C-n>", '<cmd>cnext<CR>zz<cmd>lua print("qflist: next")<CR>')

map("n", "<C-p>", '<cmd>cprev<CR>zz<cmd>lua print("qflist: prev")<CR>')

map("n", ";E", '<cmd>call setqflist([], "r")<CR><cmd>ccl<CR><cmd>lua print("qflist: clear")<CR>')

map("n", ";e", toggle_qf)

-- Editing
map("i", "<C-c>", "<Esc>", options)
map("n", "<leader><leader>", "<cmd>so<cr>", options)
map("n", "<C-t>", "<cmd>w<cr>")
map("n", "<C-q>", "<cmd>q<cr>")

-- Visual indentation
map("v", "<", "<gv", options)
map("v", ">", ">gv", options)

-- Window and tab management
map("n", "<A-z>", ":set wrap!<Return>", options)
map("n", "<leader>t", ":tabnew<Return>", options)
map("n", ">", ":tabnext<Return>", options)
map("n", "<", ":tabprev<Return>", options)

-- Clipboard
map("n", "<leader>Y", 'ggVG"+y', options)
map({ "n", "v" }, "<leader>y", [["+y]], options)
map({ "n", "v" }, "<leader>d", [["_d]], options)
map("x", "<leader>p", [["_dP]], options)
