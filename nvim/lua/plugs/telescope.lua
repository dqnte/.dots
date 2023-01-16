Plug("nvim-telescope/telescope.nvim")

-- ripgrep required for live greping

keymap("n", "<leader>ff", "<cmd>lua vim.g.telescope_wrapper('find_files')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fb", "<cmd>lua vim.g.telescope_wrapper('buffers')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fg", "<cmd>lua vim.g.telescope_wrapper('live_grep')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>gs", "<cmd>lua vim.g.telescope_wrapper('git_status')<cr>", { noremap = true, silent = true })

vim.g.telescope_wrapper = function(method)
	local theme = ""
	if vim.fn.winwidth("%") <= 90 then
		theme = "theme=dropdown"
	end
	nvim_cmd("Telescope " .. method .. " " .. theme .. " hidden=true")
end

vim.after.start_telescope = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules/",
				"__pycache__/",
				"modules/",
				".git/",
			},
			mappings = {
				i = {
					-- closes telescope on 1 escape press
					["<esc>"] = require("telescope.actions").close,
				},
			},
		},
	})
end
