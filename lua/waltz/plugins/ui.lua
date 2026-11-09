return {
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
						{
							hl = "MiniStatuslineDevinfo",
							strings = { "┃" },
						},
						{
							hl = "MiniStatuslineFilename",
							strings = { filename },
						},
						"%=",
						{
							hl = "MiniStatuslineDevinfo",
							strings = { git },
						},
						{
							hl = "MiniStatuslineDevinfo",
							strings = { diagnostics },
						},
						{
							hl = "MiniStatuslineFileinfo",
							strings = { fileinfo },
						},
						{
							hl = "MiniStatuslineFilename",
							strings = { location },
						},
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
			{
				"\\\\",
				"<cmd>Pick buffers<cr>",
				desc = "search buffers",
			},
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
}
