vim.colorschemes["rose-pine"] = function()
	vim.cmd("colorscheme rose-pine-moon")

	local p = require("rose-pine.palette")

	local shift_color = require("utils").shift_color
	local c_bg = shift_color(p.overlay:gsub("#", ""), 8)

	if vim.o.background == "dark" then
		c_bg = p.surface
	end

	vim.luatheme = {
		normal = {
			a = { bg = p.surface, fg = p.rose, gui = "bold" },
			b = { bg = p.surface, fg = p.text },
			c = { bg = p.surface, fg = p.subtle, gui = "italic" },
		},
		insert = {
			a = { bg = p.surface, fg = p.foam, gui = "bold" },
		},
		visual = {
			a = { bg = p.surface, fg = p.iris, gui = "bold" },
		},
		replace = {
			a = { bg = p.surface, fg = p.pine, gui = "bold" },
		},
		command = {
			a = { bg = p.surface, fg = p.love, gui = "bold" },
		},
		inactive = {
			a = { bg = p.base, fg = p.subtle, gui = "bold" },
			b = { bg = p.base, fg = p.subtle },
			c = { bg = p.base, fg = p.subtle, gui = "italic" },
		},
	}

	vim.luatheme = {
		normal = {
			a = { bg = p.rose, fg = p.base, gui = "bold" },
			b = { bg = p.overlay, fg = p.rose },
			c = { bg = c_bg, fg = p.text },
		},
		insert = {
			a = { bg = p.foam, fg = p.base, gui = "bold" },
			b = { bg = p.overlay, fg = p.foam },
			c = { bg = c_bg, fg = p.text },
		},
		visual = {
			a = { bg = p.iris, fg = p.base, gui = "bold" },
			b = { bg = p.overlay, fg = p.iris },
			c = { bg = c_bg, fg = p.text },
		},
		replace = {
			a = { bg = p.pine, fg = p.base, gui = "bold" },
			b = { bg = p.overlay, fg = p.pine },
			c = { bg = c_bg, fg = p.text },
		},
		command = {
			a = { bg = p.love, fg = p.base, gui = "bold" },
			b = { bg = p.overlay, fg = p.love },
			c = { bg = c_bg, fg = p.text },
		},
		inactive = {
			a = { bg = p.base, fg = p.muted, gui = "bold" },
			b = { bg = p.base, fg = p.muted },
			c = { bg = p.base, fg = p.muted },
		},
	}
end

lazy({
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 100,
	config = require("utils").enable_colorscheme,
})
