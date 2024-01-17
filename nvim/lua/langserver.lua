require("plugs/lspconfig")
require("plugs/cmp")

lazy({
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
            -- debug = true,
			sources = {
				-- python
				null_ls.builtins.formatting.black,
                null_ls.builtins.diagnostics.mypy,
				-- js/ts
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.eslint_d,
				-- lua
				null_ls.builtins.formatting.stylua,
				-- rust
				null_ls.builtins.formatting.rustfmt,
			},
		})
	end,
})
