vim.colorschemes.melange = function()
	vim.luatheme = "auto"
	nvim_cmd("colorscheme melange")
end

lazy({ "savq/melange", name = "melange", priority = 100, config = require("utils").enable_colorscheme })
