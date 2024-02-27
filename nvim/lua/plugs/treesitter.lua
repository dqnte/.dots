-- lazy("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
lazy({
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			sync_install = false,
			ignore_install = { "t32" },
			highlight = {
				enable = true,
				disable = { "c", "rust", "sql", "markdown" },
				additional_vim_regex_highlighting = false,
			},
			indent = { enabled = true },
			playground = {
				enable = false,
			},
		})

		-- context commenting said it needed this however commenting in react works
		-- without it... idk
		--
		-- require('ts_context_commentstring').setup({})
		-- vim.g.skip_ts_context_commentstring_module = true
	end,
})
-- lazy("nvim-treesitter/playground", { ["do"] = ":TSUpdate" })
