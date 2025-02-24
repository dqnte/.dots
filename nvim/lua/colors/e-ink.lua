vim.colorschemes["e-ink"] = function()
	require("e-ink").setup()
	vim.cmd("colorscheme e-ink")
end

lazy({ "alexxGmZ/e-ink.nvim", priority = 100, config = require("utils").enable_colorscheme })
