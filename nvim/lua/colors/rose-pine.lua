Plug("rose-pine/neovim")

vim.colorschemes["rose-pine"] = function()
	vim.o.background = vim.env.THEME_MODE
	vim.cmd("colorscheme rose-pine")
	nvim_cmd("hi TelescopeBorder guifg=#dfdad9 guibg=none")
	nvim_cmd("hi TelescopeNormal guifg=#797593 guibg=none")
	nvim_cmd("hi TelescopePromptNormal guifg=#575279 guibg=none")
end
