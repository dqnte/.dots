vim.colorschemes.iceberg = function()
	nvim_cmd("colorscheme iceberg")
	if vim.env.THEME_MODE == "light" then
		nvim_cmd("hi SignColumn guibg=none")
		nvim_cmd("hi GitSignsCurrentLineBlame guifg=#acb0bd")
		nvim_cmd("hi GitSignsAdd guifg=#668e3d guibg=none")
		nvim_cmd("hi GitSignsChange guibg=none guifg=#3f83a6")
		nvim_cmd("hi GitSignsDelete guibg=none guifg=#cc517a")
		nvim_cmd("hi DiagnosticSignError guifg=#e27878 guibg=none")
		nvim_cmd("hi DiagnosticSignWarn guifg=#e2a478 guibg=none")
		nvim_cmd("hi DiagnosticSignInfo guifg=#89b8c2 guibg=none")
		nvim_cmd("hi DiagnosticSignHint guifg=#6b7089 guibg=none")
		nvim_cmd("hi LineNr guibg=none guifg=#9fa7bd")
		nvim_cmd("hi Error guifg=#cc517a guibg=none")
	else
		nvim_cmd("hi GitSignsCurrentLineBlame guifg=#3d435e")
		nvim_cmd("hi SignColumn guibg=#161821")
		nvim_cmd("hi GitSignsAdd guibg=none guifg=#b4be82")
		nvim_cmd("hi GitSignsChange guibg=none guifg=#89b8c2")
		nvim_cmd("hi GitSignsDelete guibg=none guifg=#e27878")
		nvim_cmd("hi DiagnosticSignError guifg=#e27878 guibg=none")
		nvim_cmd("hi DiagnosticSignWarn guifg=#e2a478 guibg=none")
		nvim_cmd("hi DiagnosticSignInfo guifg=#89b8c2 guibg=none")
		nvim_cmd("hi DiagnosticSignHint guifg=#6b7089 guibg=none")
		nvim_cmd("hi LineNr guibg=none guifg=#444b71")
		nvim_cmd("hi Error guifg=#e27878 guibg=none")
	end

    nvim_cmd("hi Comment gui=italic cterm=italic term=italic")
end

lazy({ "cocopon/iceberg.vim", priority = 100, config = require("utils").enable_colorscheme })
