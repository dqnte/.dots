Plug("Shatur/neovim-ayu", { name = "ayu-nvim" })

vim.colorschemes.ayu = function()
	require("ayu").colorscheme()
	nvim_cmd("hi Comment gui=italic")
	nvim_cmd("hi GitSignsCurrentLineBlame guifg=#bec7d1")
end
