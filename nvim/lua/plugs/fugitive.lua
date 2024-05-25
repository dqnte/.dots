-- Fancy git command integrations
lazy({ "tpope/vim-fugitive", dependencies = {
	"tpope/vim-rhubarb",
} })

-- allows for toggleable diffs
vim.git_state = {}
vim.git_state.current = nil
vim.git_state.action = function(new_state)
	local current = vim.git_state.current

	local clear_state = function()
		vim.git_state.current = nil
		nvim_cmd("q")
	end

	-- clear state if state activated within state
	if current ~= new_state and current ~= nil then
		clear_state()
	end

	if current == new_state then
		clear_state()
	else
		vim.git_state.current = new_state
		nvim_cmd(new_state)
	end
end

local silent = { noremap = true, silent = true }
keymap("n", "<leader>gv", "<cmd>lua vim.git_state.action('Gvdiff')<CR>", silent)
keymap("n", "<leader>gh", "<cmd>lua vim.git_state.action('Ghdiff')<CR>", silent)
