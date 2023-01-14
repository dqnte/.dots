require("plugs/lualine")
require("plugs/gitsigns")
require("plugs/goyo")
require("plugs/treesitter")
require("plugs/alpha")
require("plugs/nerdtree")

-- toggle number line
keymap("n", "<leader>nn", "<cmd>set number!<CR>", { noremap = true, silent = true })

-- minimal mode
vim.g.hidden_all = false
vim.g.hide_all = function(override)
	if override ~= nil then
		-- set to opposite of override so toggling puts it at override value
		vim.g.hidden_all = not override
	end

	if vim.g.hidden_all == false then
		vim.g.hidden_all = true
		vim.opt.showmode = false
		vim.opt.ruler = false
		vim.opt.laststatus = 0
		vim.opt.showcmd = false
	else
		vim.g.hidden_all = false
		vim.opt.showmode = true
		vim.opt.ruler = true
		vim.opt.laststatus = 2
		vim.opt.showcmd = true
	end
end

keymap("n", "<leader>q", "<cmd>lua vim.g.hide_all()<CR>", { noremap = true, silent = true })

-- These toggles are written to never show NERDTree and Alpha on the same screen
vim.g.toggle_nt = function()
	if vim.g.alpha_is_open then
		vim.cmd("Alpha")
	end

	vim.cmd("NERDTreeToggle")
end

vim.g.toggle_alpha = function()
	vim.cmd("NERDTreeClose") -- always close NERDTree on Alpha open
	vim.cmd("Alpha")
end

keymap("n", "<leader>nt", "<cmd>lua vim.g.toggle_nt()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>a", "<cmd>lua vim.g.toggle_alpha()<CR>", { noremap = true, silent = true })
