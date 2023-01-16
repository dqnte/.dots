Plug("ntk148v/vim-horizon", { name = "horizon" })

vim.colorschemes.horizon = function()
	vim.luatheme = "auto"
	nvim_cmd("colorscheme horizon")
	nvim_cmd("hi GitSignsCurrentLineBlame guifg=#6c6f93 guibg=#2e303e")
end
