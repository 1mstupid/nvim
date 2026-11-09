return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local function keymap(lhs, rhs, desc, mode)
						mode = mode or "n"

						vim.keymap.set(mode, lhs, rhs, {
							buffer = args.buf,
							desc = desc,
						})
					end

					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client == nil then
						return
					end

					if client:supports_method("textDocument/signatureHelp") then
						local blink_window = require("blink.cmp.completion.windows.menu")

						local blink = require("blink.cmp")

						keymap("K", function()
							if blink_window.win:is_open() then
								blink.hide()
							end

							vim.lsp.buf.signature_help()
						end, "signature help", "i")
					end

					if client:supports_method("textDocument/definition") then
						keymap("<leader>gD", "<cmd>FzfLua lsp_definitions<cr>", "Peek definition")
					end

					if client:supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({
									bufnr = args.buf,
									id = client.id,
								})
							end,
						})
					end
				end,
			})

			-- Lua language server
			vim.lsp.config("lua_ls", {
				on_init = function(client)
					local path = client.workspace_folders
						and client.workspace_folders[1]
						and client.workspace_folders[1].name

					if not path then
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
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

						client.notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, {
							settings = client.config.settings,
						})
					end

					return true
				end,

				settings = {
					Lua = {
						format = {
							enable = false,
						},
						hint = {
							enable = true,
							arrayIndex = "Disable",
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			vim.lsp.enable("lua_ls")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"svelte",
				"latex",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"tsx",
				"typescript",
				"python",
				"vim",
				"yaml",
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
}
