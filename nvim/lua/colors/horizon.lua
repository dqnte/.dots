vim.colorschemes.horizon = function()
	vim.luatheme = "auto"
	nvim_cmd("colorscheme horizon")
	nvim_cmd("hi GitSignsCurrentLineBlame guifg=#6c6f93 guibg=#2e303e")
end

lazy({ "ntk148v/vim-horizon", name = "horizon", priority = 100, config = require("utils").enable_colorscheme })
