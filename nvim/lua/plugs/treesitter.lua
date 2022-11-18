Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

vim.loaded.start_treesitter = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		sync_install = false,
		ignore_install = { "" },
		highlight = {
			enable = true,
			disable = { "c", "rust", "sql", "vue" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enabled = true },
		context_commentstring = {
			enable = true,
		},
	})
end
