vim.colorschemes["poimandres"] = function()
	vim.cmd("colorscheme poimandres")
end

lazy({
	"olivercederborg/poimandres.nvim",
	name = "poimandres",
	priority = 100,
	config = require("utils").enable_colorscheme,
})
