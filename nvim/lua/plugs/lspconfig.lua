local function lsp_highlight_document()
	-- some colorschemes don't have hightlight groups for this
	-- we use pcall so function doesn't error if group is already set
	pcall(nvim_cmd, "hi link LspReferenceText Visual")
	pcall(nvim_cmd, "hi link LspReferenceRead Visual")
	pcall(nvim_cmd, "hi link LspReferenceWrite Visual")

	vim.cmd("autocmd CursorMoved <buffer> lua vim.g.document_highlight_toggle(false)")
end

vim.g.highlight_toggle_on = false
vim.g.document_highlight_toggle = function(override)
	-- sent to inverse of override so state will toggle to override value
	if not (override == nil) then
		vim.g.highlight_toggle_on = not override
	end

	if vim.g.highlight_toggle_on then
		vim.g.highlight_toggle_on = false
		vim.lsp.buf.clear_references()
	else
		vim.g.highlight_toggle_on = true
		vim.lsp.buf.document_highlight()
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	buf_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_keymap(bufnr, "n", "K", "<cmd>lua vim.g.document_highlight_toggle()<CR>", opts)
	buf_keymap(bufnr, "n", "D", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
	buf_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

local function on_attach(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document()

	-- disables lsp formatting so only null-ls formats
	client.server_capabilities.documentFormattingProvider = false
end

local function configure_server(server_name, opts)
	require("lspconfig")[server_name].setup(opts)
end

local function configure_vue(capabilities)
	local util = require("lspconfig.util")
	local global_ts = "/usr/local/lib/node_modules/typescript/lib"

	local function get_typescript_server_path(root_dir)
		local found_ts = ""
		local function check_dir(path)
			found_ts = util.path.join(path, "node_modules", "typescript", "lib")
			if util.path.exists(found_ts) then
				return path
			end
		end
		if util.search_ancestors(root_dir, check_dir) then
			return found_ts
		else
			return global_ts
		end
	end

	configure_server("volar", {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "vue" },
		init_options = {
			typescript = {
				-- using root typescript directory
				tsdk = get_typescript_server_path(vim.fn.getcwd()),
			},
		},
		on_new_config = function(new_config, new_root_dir)
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end,
	})
end

local function configure_lsp()
	require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	configure_server("lua_ls", {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
	configure_server("pyright", {
		on_attach = on_attach,
		capabilities = capabilities,
		before_init = function(_, config)
			local Path = require("plenary.path")
			local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
			if venv:joinpath("bin"):is_dir() then
				config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
			else
				config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
			end
		end,
	})
	configure_server("rust_analyzer", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	configure_server("tsserver", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	configure_server("kotlin_language_server", {
		on_attach = on_attach,
		capabilities = capabilities,
        -- kls caches in the root directory of the project by default
		init_options = { storagePath = vim.fn.expand("$HOME/.cache/") },
	})

	configure_vue(capabilities)
end

local function configure_diagnostics()
	local signs = {
		{ name = "DiagnosticSignError", text = "裸" },
		{ name = "DiagnosticSignWarn", text = "勞" },
		{ name = "DiagnosticSignHint", text = "勞" },
		{ name = "DiagnosticSignInfo", text = " " },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, {
			texthl = sign.name,
			text = sign.text,
			numhl = "",
		})
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			guibg = "red",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)
end

local function configure_installer()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls" },
	})
end

lazy({
	"neovim/nvim-lspconfig",
	config = function()
		-- configure_installer()
		configure_lsp()
		configure_diagnostics()
	end,
})
