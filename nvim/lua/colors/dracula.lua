Plug("dracula/vim", { name = "dracula" })

vim.colorschemes.dracula = function()
	nvim_cmd("colorscheme dracula")
	nvim_cmd("hi Cursorline ctermbg=233 guibg=#22242e")
	nvim_cmd("hi CursorlineNR ctermbg=233 guibg=#22242e")
	nvim_cmd("hi Normal guibg=#15161c")
end
