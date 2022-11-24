Plug("jose-elias-alvarez/null-ls.nvim")

vim.loaded.start_null_ls = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			-- python
			null_ls.builtins.diagnostics.flake8,
			-- null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.formatting.black,
			-- js/ts
			null_ls.builtins.formatting.prettierd,
            null_ls.builtins.formatting.eslint_d,
			-- lua
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.rustfmt,
		},
	})
end
