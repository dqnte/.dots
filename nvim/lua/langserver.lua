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
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black", "isort" },
				typescript = { {  "prettier" } },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				rust = { "rustfmt" },
				kotlin = { "ktlint" },
			},
			formatters = {
				prettier = {
					command = "./node_modules/.bin/prettier",
				},
			},
		})
	end,
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true })
end)
