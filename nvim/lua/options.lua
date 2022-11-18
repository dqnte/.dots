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
}

-- toggle number line
keymap("n", "<leader>nn", "<cmd>set number!<CR>", { noremap = true, silent = true })

-- minimal mode
vim.g.hidden_all = 0
vim.g.hide_all = function()
	if vim.g.hidden_all == 0 then
		vim.g.hidden_all = 1
		vim.opt.showmode = false
		vim.opt.ruler = false
		vim.opt.laststatus = 0
		vim.opt.showcmd = false
	else
		vim.g.hidden_all = 0
		vim.opt.showmode = true
		vim.opt.ruler = true
		vim.opt.laststatus = 2
		vim.opt.showcmd = true
	end
end

keymap("n", "<leader>q", "<cmd>lua vim.g.hide_all()<CR>", { noremap = true, silent = true })

-- restore cursor to beam on exit
vim.api.nvim_exec(
	[[
        augroup RestoreCursorShapeOnExit
            autocmd!
            autocmd VimLeave * set guicursor=a:ver20
        augroup END
    ]],
	false
)

for k, v in pairs(options) do
	vim.opt[k] = v
end
