return {
	-- Dashboard
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = {
			"echasnovski/mini.pick",
			"echasnovski/mini.extra",
		},
		config = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                   ",
				"            ╔════════╗             ",
				"            ║  p w n ║             ",
				"            ╚════════╝             ",
				"          > build. exploit. repeat.",
				"                                   ",
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "    Find files", "<cmd>lua MiniPick.builtin.files()<CR>"),
				dashboard.button("r", "    Recent", "<cmd>lua MiniExtra.pickers.oldfiles()<CR>"),
				dashboard.button("c", "    Nvim config", "<cmd>edit $MYVIMRC<CR>"),
				dashboard.button("p", "    Projects", "<cmd>lua MiniPick.builtin.grep_live()<CR>"),
				dashboard.button("q", "  󰗼  Quit", "<cmd>qa<CR>"),
			}

			dashboard.section.footer.val = "cwd: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

			dashboard.config.layout = {
				{ type = "padding", val = 4 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

			require("alpha").setup(dashboard.config)
		end,
	},

	-- Highlight TODO, FIXME, HACK, NOTE and hex colors

	{
		"echasnovski/mini.hipatterns",
		version = false,
		event = "BufReadPost",
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

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- Statusline
	{
		"echasnovski/mini.statusline",
		version = false,
		event = "VeryLazy",
		opts = {
			use_icons = false,
			set_vim_settings = false,
			content = {
				active = function()
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

	-- Indent scope
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

	-- Mini Pick
	{
		"echasnovski/mini.pick",
		version = false,
		cmd = "Pick",
		keys = {
			{ ";f", "<cmd>Pick files<cr>", desc = "Files" },
			{ ";r", "<cmd>Pick grep_live<cr>", desc = "Grep" },
			{ "\\\\", "<cmd>Pick buffers<cr>", desc = "Search buffers" },
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

	-- Mini Extra
	{
		"echasnovski/mini.extra",
		lazy = false,
		version = false,
	},
}
