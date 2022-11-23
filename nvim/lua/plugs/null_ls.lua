Plug("jose-elias-alvarez/null-ls.nvim")

-- To install stylua:
--
-- Install rust:
-- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
-- Install stylua:
-- cargo install stylua

vim.loaded.start_null_ls = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			-- python
			null_ls.builtins.diagnostics.flake8,
			-- null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.formatting.black,
			-- js/ts
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.eslint,
			-- lua
			null_ls.builtins.formatting.stylua,
		},
	})
end
