Plug("jose-elias-alvarez/null-ls.nvim")

-- To install stylua:
--
-- Install rust:
-- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
-- Install stylua:
-- cargo install stylua

vim.loaded.start_null_ls = function()
	local on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end

	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			-- python
			null_ls.builtins.diagnostics.flake8,
			null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.formatting.black,
			-- js/ts
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.formatting.prettier,
			-- lua
			null_ls.builtins.formatting.stylua,
		},
		-- format on save
		-- on_attach = on_attach,
	})
end
