vim.colorschemes.nightfox = function()
	require("nightfox").load()
end

lazy({ "EdenEast/nightfox.nvim", priority = 100, config = require("utils").enable_colorscheme })
