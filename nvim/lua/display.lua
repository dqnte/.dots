require("plugs/lualine")
require("plugs/alpha")
require("plugs/gitsigns")
require("plugs/goyo")
require("plugs/treesitter")

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

-- Disable Lualine when displaying Alpha menu
vim.cmd([[autocmd User AlphaReady lua vim.g.hide_all(true)]])
vim.cmd([[autocmd User AlphaClosed lua vim.g.hide_all(false)]])
