vim.colorschemes.dracula = function()
	vim.cmd("colorscheme dracula")
	hi("Cursorline ctermbg=233 guibg=#22242e")
	hi("CursorlineNR ctermbg=233 guibg=#22242e")
	hi("Normal guibg=#15161c")
end

lazy({
	"dracula/vim",
	name = "dracula",
	priority = 100,
	config = require('utils').enable_colorscheme,
})
