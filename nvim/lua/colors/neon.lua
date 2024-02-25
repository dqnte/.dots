vim.colorschemes["neon"] = function()
    local bg = nil
    local p = require("neon.colors")

	if vim.o.background == "light" then
		vim.g.neon_style = "light"
        bg = p.bg1
    else
        vim.g.neon_style = 'doom'
        bg = p.bg4
	end

    vim.luatheme = {
		normal = {
			a = { bg = p.dark_cyan, fg = p.bg0, gui = "bold" },
			b = { bg = bg, fg = p.fg},
			c = { bg = bg, fg = p.fg, gui = "italic" },
		},
		insert = {
			a = { bg = p.blue, fg = p.bg0, gui = "bold" },
		},
		visual = {
			a = { bg = p.purple, fg = p.bg0, gui = "bold" },
		},
		replace = {
			a = { bg = bg, fg = p.fg, gui = "bold" },
		},
		command = {
			a = { bg = p.red, fg = p.bg0, gui = "bold" },
		},
		inactive = {
			a = { bg = bg, fg = p.fg, gui = "bold" },
			b = { bg = bg, fg = p.fg},
			c = { bg = bg, fg = p.fg, gui = "italic" },
		},
	}

	vim.cmd("colorscheme neon")
end


lazy({ "rafamadriz/neon", priority = 100, config = require("utils").enable_colorscheme })
