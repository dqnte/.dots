Plug("nvim-lualine/lualine.nvim")

vim.loaded.start_lualine = function()
	require("lualine").setup({
		options = {
			theme = vim.luatheme == nil and vim.env.THEME or vim.luatheme,
			disabled_filetypes = { "markdown", "txt" },
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

-- Disable Lualine when displaying Alpha menu
vim.cmd([[autocmd User AlphaReady lua vim.g.hide_all()]])
vim.cmd([[autocmd User AlphaClosed lua vim.g.hide_all()]])
