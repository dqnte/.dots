Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

local function start_treesitter()
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "maintained",
		sync_install = false,
		ignore_install = { "" },
		highlight = {
			enable = true,
			disable = { "c", "rust" },
			additional_vim_regex_highlighting = true,
		},
		indent = { enabled = true }
	}
end

vim.loaded.start_treesitter = start_treesitter
