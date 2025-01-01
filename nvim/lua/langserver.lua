require("plugs/lspconfig")
require("plugs/cmp")

local function find_poetry_bin_path(cmd)
	local file = vim.fn.findfile(".venv/bin/" .. cmd, ";Fabric;Code")

	if file == "" then
		return cmd
	else
		return file
	end
end

local function find_pnpm_options()
	local file = vim.fn.findfile("node_modules/.bin/pnpm", ";Fabric;Code")

	if file == "" then
		return {}
	else
		return {
			command = "pnpm",
			args = {
				"prettier",
				"--stdin-filepath",
				"$FILENAME",
			},
		}
	end
end

lazy({
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			-- debug = true,
			sources = {
				-- python
				-- null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.formatting.black.with({
					command = find_poetry_bin_path("black"),
				}),
				null_ls.builtins.diagnostics.mypy.with({
					command = find_poetry_bin_path("mypy"),
				}),
				null_ls.builtins.formatting.isort.with({
					command = find_poetry_bin_path("isort"),
				}),
				-- js/ts
				null_ls.builtins.formatting.prettier.with(find_pnpm_options()),
				null_ls.builtins.formatting.eslint,
				-- lua
				null_ls.builtins.formatting.stylua,
				-- rust
				null_ls.builtins.formatting.rustfmt,
				-- kotlin
				null_ls.builtins.formatting.ktlint,
			},
		})
	end,
})
