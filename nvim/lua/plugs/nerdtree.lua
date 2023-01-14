Plug("preservim/nerdtree")

-- close vim when nerdtree is last window
autocmd({ "BufEnter" }, {
	pattern = { "*" },
	command = [[ if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]],
})
