Plug("neovim/nvim-lspconfig")
Plug("williamboman/nvim-lsp-installer")

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
	local lsp_installer_servers = require("nvim-lsp-installer.servers")
	local active, server = lsp_installer_servers.get_server(server_name)

	if active then
		server:on_ready(function()
			server:setup(opts)
		end)
	else
		if not server:is_installed() then
			server:install()
		end
	end
end

local function configure_lsp()
	require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	configure_server("sumneko_lua", {
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
			},
		},
	})
	configure_server("bashls", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	configure_server("vuels", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	configure_server("tsserver", {
		on_attach = on_attach,
	})
	configure_server("pyright", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	configure_server("rust_analyzer", {
		on_attach = on_attach,
		capabilities = capabilities,
	})
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
			-- border = "single",
			guibg = "red",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)
end

vim.loaded.start_lsp = function()
	configure_lsp()
	configure_diagnostics()
end
