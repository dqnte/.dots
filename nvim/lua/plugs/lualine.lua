Plug("nvim-lualine/lualine.nvim")

vim.loaded.start_lualine = function()
	require("lualine").setup({
		options = {
			theme = vim.luatheme == nil and vim.env.THEME or vim.luatheme,
			disabled_filetypes = { "markdown", "text" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "FugitiveHead" },
			lualine_c = {},
			lualine_x = { "diff" },
			lualine_y = { "filename" },
			lualine_z = { "progress" },
		},
	})
end
