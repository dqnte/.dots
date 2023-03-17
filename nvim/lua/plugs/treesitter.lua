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
			context_commentstring = {
				enable = true,
			},
			playground = {
				enable = false,
			},
		})
	end,
})
-- lazy("nvim-treesitter/playground", { ["do"] = ":TSUpdate" })
