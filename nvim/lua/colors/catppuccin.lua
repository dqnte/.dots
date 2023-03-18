vim.colorschemes["catppuccin"] = function()
	local flavour = "mocha"
	if vim.env.THEME_MODE == "light" then
		flavour = "latte"
	end

	require("catppuccin").setup({
		flavour = flavour,
		background = { light = "latte", dark = "mocha" },
		show_end_of_buffer = true,
		no_italic = false,
		no_bold = false,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = false,
			telescope = true,
			notify = false,
			hop = true,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	})

	vim.cmd("colorscheme catppuccin")
end

lazy({
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 100,
	config = require("utils").enable_colorscheme,
})
