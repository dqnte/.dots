vim.colorschemes.nord = function()
	nvim_cmd("colorscheme nord")
end

lazy({ "shaunsingh/nord.nvim", priority = 100, config = require("utils").enable_colorscheme })
