Plug 'nvim-telescope/telescope.nvim'

-- ripgrep required for live greping

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

local function start_telescope()
	local telescope = require("telescope")
	telescope.setup {
		defaults = {
			file_ignore_patterns = {
				"node_modules", "__pycache__", "modules",
			}
		}
	}
	-- telescope.load_extension('fzf')
end

vim.loaded.start_telescope = start_telescope
