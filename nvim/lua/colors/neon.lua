vim.colorschemes["neon"] = function()
	if vim.o.background == "light" then
		vim.g.neon_style = "light"
    else
        vim.g.neon_style = 'doom'
	end

	vim.cmd("colorscheme neon")
end

lazy({ "rafamadriz/neon", priority = 100, config = require("utils").enable_colorscheme })
