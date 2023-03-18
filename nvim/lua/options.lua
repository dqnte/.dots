-- Basic Settings
local options = {
	showmatch = true,
	ignorecase = true, -- case insensitive
	smartcase = true,
	incsearch = true, -- incremental search
	hlsearch = false,
	tabstop = 4, -- number of columns occupied by a tab
	softtabstop = 4,
	expandtab = true, -- converts tabs to white space
	shiftwidth = 4, -- width for autoindents
	autoindent = true, -- indent a new line the same amount as the line just typed
	number = false, -- line numbers
	wildmode = "longest,list", -- get bash-like tab completions
	syntax = "on", -- syntax highlighting
	mouse = "a", -- enable mouse click
	clipboard = "unnamedplus", -- using system clipboard
	ttyfast = true, -- Speed up scrolling in Vim
	swapfile = false, -- disable creating swap file
	signcolumn = "yes", -- prevent sign column from shifting
	encoding = "UTF-8",
	updatetime = 300,
	cursorline = true,
	termguicolors = true,
	scrolloff = 5,
	sidescrolloff = 8,
	background = vim.env.THEME_MODE ~= "" and vim.env.THEME_MODE or "dark",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = ","
