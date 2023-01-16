Plug("Lokaltog/vim-monotone")

vim.colorschemes.mono = function()
	local colors = {
		black = "#121111",
		white = "#d2cfcf",
		red = "#7788aa",
		green = "#88aa77",
		blue = "#d2cfcf",
		yellow = "#d2cfcf",
		gray = "#d2cfcf",
		darkgray = "#504945",
		lightgray = "#767676",
		inactivegray = "#262626",
	}

	local a = { bg = colors.gray, fg = colors.black, gui = "bold" }
	local b = { bg = colors.darkgray, fg = colors.white }
	local c = { bg = colors.inactivegray, fg = colors.gray }

	local theme = {
		normal = {
			a = a,
			b = b,
			c = c,
		},
		insert = {
			a = a,
			b = b,
			c = c,
		},
		visual = {
			a = a,
			b = b,
			c = c,
		},
		replace = {
			a = a,
			b = b,
			c = c,
		},
		command = {
			a = a,
			b = b,
			c = c,
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.gray },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
	}

	vim.luatheme = theme
	vim.g.monotone_emphasize_comments = 1
	nvim_cmd("colorscheme monotone")
	nvim_cmd("hi Comment guifg=#767676")
	nvim_cmd("hi NonText guifg=#5c5c5c")
	nvim_cmd("hi EndOfBuffer guifg=#2b2b2b")
end
