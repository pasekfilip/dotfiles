return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("blink.cmp")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(event)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local buf = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local opts = { buffer = buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- show lsp definitions
				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end
				, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end
				, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Show signature help"
				keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- show documentation for what is under cursor

				-- opts.desc = "Restart LSP"
				-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				if client and client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
						buffer = buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = buf })
						end,
					})
				end
			end,
		})

		vim.diagnostic.config({
			underline = true,
			virtual_text = { current_line = true },
			virtual_lines = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				}
			},
			update_in_insert = false,
			severity_sort = false,
			float = false
		})

		local capabilities = cmp_nvim_lsp.get_lsp_capabilities();
		capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

		vim.lsp.config('clangd', {
			cmd = {
				"clangd",
				"--clang-tidy",
				"--query-driver=C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/bin/*",
				"--background-index"
			},
			capabilities = capabilities,
			init_options = {
				fallbackFlags =
				{
					"--target=x86_64-w64-windows-gnu",
					"--std=gnu++23",
					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/"
					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
				}
			}
		})

		-- Set your Java path
		local java_exec = "C:/Program Files/Amazon Corretto/jdk21.0.7_6/bin/java.exe"

		-- Find the JAR file installed by Mason
		local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
		local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
		local config_dir = jdtls_path .. "/config_win" -- use config_linux / config_mac if needed
		local workspace_dir = vim.fn.stdpath("data") ..
			"/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

		vim.lsp.config("jdtls", {
			cmd = {
				java_exec,
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens", "java.base/java.util=ALL-UNNAMED",
				"--add-opens", "java.base/java.lang=ALL-UNNAMED",
				"-jar", launcher_jar,
				"-configuration", config_dir,
				"-data", workspace_dir,
			},
			capabilities = capabilities,
			filetypes = { "java" },
			root_markers = { ".git", "pom.xml", "build.gradle" },
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = "C:/Program Files/Amazon Corretto/jdk21.0.7_6/"
							},
						},
					},
				},
			},
		})
		vim.lsp.enable("jdtls")

		local node_modules_path = "C:\\Users\\filip\\AppData\\Local\\nvm\\v20.11.1\\node_modules"
		vim.lsp.config('angularls', {
			cmd = {
				'ngserver',
				'--stdio',
				'--tsProbeLocations', node_modules_path,
				'--ngProbeLocations', node_modules_path
			},
			filetypes = { "ts", 'html' },
			root_markers = { 'angular.json', 'project.json', 'package.json', '.git' },
		})
		vim.lsp.enable("angularls")


		-- vim.lsp.config('angularls', {
		-- 	cmd = {
		-- 		'node',
		-- 		vim.fn.getcwd() .. '/node_modules/@angular/language-server/bin/ngserver',
		-- 		'--stdio',
		-- 		'--tsProbeLocations', vim.fn.getcwd() .. '/node_modules',
		-- 		'--ngProbeLocations', vim.fn.getcwd() .. '/node_modules/@angular/language-service'
		-- 	},
		-- 	filetypes = { 'typescript', 'html', 'ts' },
		-- 	root_dir = vim.fs.root(0, { 'angular.json', 'tsconfig.app.json', 'tsconfig.json' }),
		-- 	capabilities = capabilities,
		-- })
		--
		-- vim.lsp.enable('angularls')

		-- mason_lspconfig.setup_handlers({
		-- 	-- default handler for installed servers
		-- 	function(server_name)
		-- 		lspconfig[server_name].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 		})
		-- 	end,
		-- 	["pyright"] = function()
		-- 		lspconfig["pyright"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			settings = {
		-- 				analysis = {
		-- 					autoSearchPaths = true,
		-- 					diagnosticMode = "openFilesOnly",
		-- 					useLibraryCodeForTypes = true
		-- 				}
		-- 			}
		-- 		})
		-- 	end,
		--
		-- 	["clangd"] = function()
		-- 		lspconfig["clangd"].setup({
		-- 			cmd = {
		-- 				"clangd",
		-- 				"--clang-tidy",
		-- 				"--query-driver=C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/bin/*",
		-- 				"--background-index"
		-- 			},
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			init_options = {
		-- 				fallbackFlags =
		-- 				{
		-- 					"--target=x86_64-w64-windows-gnu",
		-- 					"--std=gnu++23",
		-- 					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/"
		-- 					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
		-- 					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
		-- 					-- "-I  C:/Users/Filip/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/include/
		-- 				}
		-- 			}
		-- 		})
		-- 	end
		-- })
	end,
}
