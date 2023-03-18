vim.colorschemes["everforest"] = function()
	vim.g.everforest_enable_italic = 1
	vim.g.everforest_background = "soft"
	vim.cmd("colorscheme everforest")
end

lazy({ "sainnhe/everforest", priority = 100, config = require("utils").enable_colorscheme })
