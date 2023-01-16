Plug("savq/melange", { name = "melange" })

vim.colorschemes.melange = function()
	vim.luatheme = "auto"
	nvim_cmd("colorscheme melange")
end
