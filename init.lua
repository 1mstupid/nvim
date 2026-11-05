vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.opt.guicursor = "a:blinkon6"
vim.o.sw = 2
vim.o.ts = 2
vim.o.et = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

vim.opt.list = true
vim.opt.listchars = {
  lead = " ",
  trail = " ",
  tab = "  ╎",
}

vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:blinkon6",
}

vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.isfname:append("@-@")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.o.mouse = "a"
vim.o.swapfile = false
vim.opt.isfname:append("@-@")
vim.o.backup = false

local function toggle_qf()
	local win_id = vim.fn.getqflist({ winid = 0 }).winid
	if win_id ~= nil and win_id ~= 0 then
		vim.cmd("ccl")
	else
		vim.cmd("copen")
		vim.cmd("wincmd p")
	end
end

local options = { noremap = true, silent = true }
vim.keymap.set("n", "<C-n>", '<cmd>cnext<CR>zz<cmd>lua print("qflist: next")<CR>')
vim.keymap.set("n", "<C-p>", '<cmd>cprev<CR>zz<cmd>lua print("qflist: prev")<CR>')
vim.keymap.set("n", ";E", '<cmd>call setqflist([], "r")<CR><cmd>ccl<CR><cmd>lua print("qflist: clear")<CR>')
vim.keymap.set("n", ";e", toggle_qf)
vim.keymap.set("i", "<C-c>", "<Esc>", options)
vim.keymap.set("n", "<leader><leader>", "<cmd>so<cr>", options)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "<", "<gv", options)
vim.keymap.set("v", ">", ">gv", options)
vim.keymap.set("n", "<A-z>", ":set wrap!<Return>", options)
vim.keymap.set("n", "<leader>t", ":tabnew<Return>", options)
vim.keymap.set("n", ">", ":tabnext<Return>", options)
vim.keymap.set("n", "<", ":tabprev<Return>", options)
vim.keymap.set("n", "<leader>Y", 'ggVG"+y', options)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], options)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], options)
vim.keymap.set("x", "<leader>p", [["_dP]], options)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp = vim.opt.rtp ^ lazypath

require("lazy").setup({
	root = vim.fn.stdpath("data") .. "/waltz/lazy",
	spec = {
		{
			"stevearc/oil.nvim",
			lazy = false,
			keys = {
				{ "<leader>e", "<cmd>Oil<cr>" },
			},
			opts = {
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
				},
			},
		},
		{
			"echasnovski/mini.statusline",
			main = "mini.statusline",
			lazy = false,
			opts = {
			  use_icons = false,
			  set_vim_settings = false,

			  content = {
			    active = function()
			      local MiniStatusline = require("mini.statusline")

			      local mode, mode_hl = MiniStatusline.section_mode({
			        trunc_width = 120,
			      })

			      local filename = MiniStatusline.section_filename({
			        trunc_width = 140,
			      })

			      local git = MiniStatusline.section_git({
			        trunc_width = 40,
			      })

			      local diagnostics = MiniStatusline.section_diagnostics({
			        trunc_width = 75,
			      })

			      local fileinfo = MiniStatusline.section_fileinfo({
			        trunc_width = 120,
			      })

			      local location = MiniStatusline.section_location({
			        trunc_width = 75,
			      })

			      return MiniStatusline.combine_groups({
			        { hl = mode_hl, strings = { mode } },
			        { hl = "MiniStatuslineDevinfo", strings = { "┃" } },
			        { hl = "MiniStatuslineFilename", strings = { filename } },
			        "%=",
			        { hl = "MiniStatuslineDevinfo", strings = { git } },
			        { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
			        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
			        { hl = "MiniStatuslineFilename", strings = { location } },
			      })
			    end,
			  },
			},
		},
		
		{
		  "echasnovski/mini.indentscope",
		  version = false,
		  event = { "BufReadPre", "BufNewFile" },
		  opts = {
		    symbol = "╎",
		    draw = {
		      delay = 0,
		      animation = function()
		        return 0
		      end,
		    },
		    options = {
		      border = "both",
		      indent_at_cursor = true,
		    },
		  },
		},

		{
			"echasnovski/mini.pick",
			main = "mini.pick",
			cmd = "Pick",
			keys = {
				{ ";f", "<cmd>Pick files<cr>", desc = "files" },
				{ ";r", "<cmd>Pick grep_live<cr>", desc = "grep" },
				{ "\\\\", "<cmd>Pick buffers<cr>", desc = "search buffers" },
			},
			opts = {
				delay = {
					async = 10,
					busy = 50,
				},
				mappings = {
					toggle_preview = "<Tab>",
					choose_all = {
						char = "<C-l>",
						func = function()
							local pick = require("mini.pick")
							local mappings = pick.get_picker_opts().mappings
							vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
						end,
					},
				},
				options = {
					content_from_bottom = false,
					use_cache = true,
				},
			},
		},
		{
		  "epwalsh/obsidian.nvim",
		  version = "*",  -- recommended, use latest release instead of latest commit
		  lazy = true,
		  ft = "markdown",
		  dependencies = {
		    "nvim-lua/plenary.nvim",
		  },
		  opts = {
		    workspaces = {
		      {
		        name = "personal",
		        path = "~/Documents/notes",
		      },
		    },
		  },
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {},
		},
		{
			"echasnovski/mini.hipatterns",
			main = "mini.hipatterns",
			event = { "BufReadPost" },
			config = function()
				local hipatterns = require("mini.hipatterns")
				hipatterns.setup({
					highlighters = {
						fixme = {
							pattern = "%f[%w]()FIXME()%f[%W]",
							group = "MiniHipatternsFixme",
						},
						hack = {
							pattern = "%f[%w]()HACK()%f[%W]",
							group = "MiniHipatternsHack",
						},
						todo = {
							pattern = "%f[%w]()TODO()%f[%W]",
							group = "MiniHipatternsTodo",
						},
						note = {
							pattern = "%f[%w]()NOTE()%f[%W]",
							group = "MiniHipatternsNote",
						},
						hex_color = hipatterns.gen_highlighter.hex_color(),
					},
				})
			end,
		},
		{
			"saghen/blink.cmp",
			event = "InsertEnter",
			version = "*",
			opts = {
				keymap = {
					["<CR>"] = { "accept", "fallback" },
					["<C-e>"] = { "hide", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev" },
				},
				cmdline = {
					sources = {},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			event = "BufWritePre",
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
					},
					format_on_save = {
						timeout_ms = 500,
						lsp_format = "fallback",
					},
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local function keymap(lhs, rhs, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = desc })
						end
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client == nil then
							return
						end
						if client.supports_method("textDocument/signatureHelp") then
							local blink_window = require("blink.cmp.completion.windows.menu")
							local blink = require("blink.cmp")
							keymap("K", function()
								if blink_window.win:is_open() then
									blink.hide()
								end
								vim.lsp.buf.signature_help()
							end, "signature help", "i")
						end
						if client.supports_method("textDocument/definition") then
							keymap("<leader>gD", "<cmd>FzfLua lsp_definitions<cr>", "Peek definition")
						end
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = args.buf,
								callback = function()
									vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
								end,
							})
						end
					end,
				})

				require("lspconfig").lua_ls.setup({
					on_init = function(client)
						local path = client.workspace_folders
							and client.workspace_folders[1]
							and client.workspace_folders[1].name
						if not path then
							client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME,
											"${3rd}/luv/library",
										},
									},
								},
							})
							client.notify(
								vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
								{ settings = client.config.settings }
							)
						end

						return true
					end,
					settings = {
						Lua = {
							format = { enable = false },
							hint = {
								enable = true,
								arrayIndex = "Disable",
							},
							completion = { callSnippet = "Replace" },
						},
					},
				})
			end,
		},
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = {
          "gitcommit",
          "json",
          "json5",
          "jsonc",
          "lua",
          "nix",
        },
      },
      config = function(_, opts)
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
          install_dir = vim.fn.stdpath("data") .. "/site",
        })

        treesitter.install(opts.ensure_installed)
      end,
    },
		defaults = {
			lazy = true,
		},
		install = {
			missing = false,
		},
		change_detection = { notify = false },
		rocks = {
			enabled = false,
		},
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"netrwPlugin",
					"netrw",
					"matchit",
					"matchparen",
					"vimball",
					"vimballPlugin",
					"rplugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	},
})

local theme = require("waltz.init")

theme.setup({
	theme = "auto",
	transparent = true,
	italics = {
		comments = false,
		keywords = true,
		functions = true,
		strings = false,
		variables = true,
	},
})

theme.colorscheme()
