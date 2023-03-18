vim.colorschemes.monochrome = function()
	vim.luatheme = "auto"
	vim.g.monochrome_italic_comments = 1
	nvim_cmd("colorscheme monochrome")
	nvim_cmd("highlight SignColumn ctermbg=0")
	nvim_cmd("highlight diffAdded guibg=none guifg=white")
	nvim_cmd("highlight GitSignsAdd ctermfg=4 guibg=none")
	nvim_cmd("highlight GitSignsChange ctermfg=5 guibg=none")
	nvim_cmd("highlight GitSignsDelete ctermfg=12 guibg=none")
end

lazy({ "fxn/vim-monochrome", priority = 100, config = require("utils").enable_colorscheme })
