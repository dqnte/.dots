vim.colorschemes.palenight = function()
	vim.luatheme = "auto"
	nvim_cmd("colorscheme palenight")
	nvim_cmd("hi Normal guibg=#181a24")
	nvim_cmd("hi Cursorline guibg=#1f2430")
	nvim_cmd("hi Comment gui=italic")
end

lazy({ "drewtempelmeyer/palenight.vim", priority = 100, config = require("utils").enable_colorscheme })
