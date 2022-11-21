require("plugs/lualine")
require("plugs/alpha")
require("plugs/gitsigns")
require("plugs/goyo")

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
