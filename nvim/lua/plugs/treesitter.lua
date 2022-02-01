Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

vim.loaded.start_treesitter = function ()
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "maintained",
		sync_install = false,
		ignore_install = { "" },
		highlight = {
			enable = true,
			disable = { "c", "rust" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enabled = true }
	}
end
