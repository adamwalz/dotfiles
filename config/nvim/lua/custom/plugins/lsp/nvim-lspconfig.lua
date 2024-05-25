return {
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
		{ "folke/neodev.nvim", opts = {} },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	---@class PluginLspOpts
	opts = {
		-- options for vim.diagnostic.config()
		---@type vim.diagnostic.Opts
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
			},
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
					[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
					[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
					[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
				},
			},
		},
		-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the inlay hints.
		inlay_hints = {
			enabled = true,
		},
		-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
		-- Be aware that you also will need to properly configure your LSP server to
		-- provide the code lenses.
		codelens = {
			enabled = false,
		},
		-- Enable lsp cursor word highlighting
		document_highlight = {
			enabled = true,
		},
		-- add any global capabilities here
		capabilities = {},
		-- options for vim.lsp.buf.format
		-- `bufnr` and `filter` is handled by the LazyVim formatter,
		-- but can be also overridden when specified
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@type lspconfig.options
		servers = {
			gopls = {
				keys = {
					-- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
					{ "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
				},
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			},
			lua_ls = {
				-- mason = false, -- set to false if you don't want this server to be installed with mason
				-- Use this to add any additional keymaps
				-- for specific lsp servers
				---@type LazyKeysSpec[]
				-- keys = {},
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
			rust_analyzer = {},
			taplo = {
				keys = {
					{
						"K",
						function()
							if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
								require("crates").show_popup()
							else
								vim.lsp.buf.hover()
							end
						end,
						desc = "Show Crate Documentation",
					},
				},
			},
		},
		-- you can do any additional lsp server setup here
		-- return true if you don't want this server to be setup with lspconfig
		---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
		setup = {
			-- example to setup with typescript.nvim
			-- tsserver = function(_, opts)
			--   require("typescript").setup({ server = opts })
			--   return true
			-- end,
			-- Specify * to use this function as a fallback for any server
			-- ["*"] = function(server, opts) end,
			gopls = function(_, opts)
				-- workaround for gopls not supporting semanticTokensProvider
				-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
				LazyVim.lsp.on_attach(function(client, _)
					if client.name == "gopls" then
						if not client.server_capabilities.semanticTokensProvider then
							local semantic = client.config.capabilities.textDocument.semanticTokens
							client.server_capabilities.semanticTokensProvider = {
								full = true,
								legend = {
									tokenTypes = semantic.tokenTypes,
									tokenModifiers = semantic.tokenModifiers,
								},
								range = true,
							}
						end
					end
				end)
				-- end workaround
			end,
			rust_analyzer = function()
				return true
			end,
		},
	},
	---@param opts PluginLspOpts
	config = function(_, opts)
		if LazyVim.has("neoconf.nvim") then
			require("neoconf").setup(LazyVim.opts("neoconf.nvim"))
		end

		-- setup autoformat
		LazyVim.format.register(LazyVim.lsp.formatter())

		-- setup keymaps
		LazyVim.lsp.on_attach(function(client, buffer)
			require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
		end)

		LazyVim.lsp.setup()
		LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

		LazyVim.lsp.words.setup(opts.document_highlight)

		-- diagnostics signs
		if vim.fn.has("nvim-0.10.0") == 0 then
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end
		end

		if vim.fn.has("nvim-0.10") == 1 then
			-- inlay hints
			if opts.inlay_hints.enabled then
				LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
					LazyVim.toggle.inlay_hints(buffer, true)
				end)
			end

			-- code lens
			if opts.codelens.enabled and vim.lsp.codelens then
				LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
					vim.lsp.codelens.refresh()
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = buffer,
						callback = vim.lsp.codelens.refresh,
					})
				end)
			end
		end

		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = require("lazyvim.config").icons.diagnostics
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local servers = opts.servers
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			has_cmp and cmp_nvim_lsp.default_capabilities() or {},
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		-- get all the servers that are available through mason-lspconfig
		local have_mason, mlsp = pcall(require, "mason-lspconfig")
		local all_mslp_servers = {}
		if have_mason then
			all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
		end

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					setup(server)
				elseif server_opts.enabled ~= false then
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		if have_mason then
			mlsp.setup({
				ensure_installed = vim.tbl_deep_extend(
					"force",
					ensure_installed,
					LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
				),
				handlers = { setup },
			})
		end

		if LazyVim.lsp.get_config("denols") and LazyVim.lsp.get_config("tsserver") then
			local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			LazyVim.lsp.disable("tsserver", is_deno)
			LazyVim.lsp.disable("denols", function(root_dir)
				return not is_deno(root_dir)
			end)
		end
	end,
}
